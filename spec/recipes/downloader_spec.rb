require 'spec_helper'

describe 'chef-cookbook-wordpress::downloader' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(cookbook_path: '../').converge(described_recipe)
  end

  context 'default attributes context' do
    it 'uses HTTPS as default protocol to download Wordpress' do
      expect(chef_run.node['wordpress']['downloader']['protocol']).to eq('https')
    end

    it 'uses the default Wordpress site URL as download source' do
      expect(chef_run.node['wordpress']['downloader']['source']).to eq('wordpress.org')
    end

    it 'uses the latest Wordpress version as default package to download' do
      expect(chef_run.node['wordpress']['downloader']['package_version']).to eq('latest')
    end

    it 'uses zip as default package type to download' do
      expect(chef_run.node['wordpress']['downloader']['package_type']).to eq('zip')
    end

    it 'uses the current directory as default destination directory to place the package under' do
      expect(chef_run.node['wordpress']['downloader']['destination']).to eq('./')
    end

    it 'uses the default destination filename for the package to be downloaded' do
      expect(chef_run.node['wordpress']['downloader']['destination_filename']).to eq('wordpress-latest')
    end

    it 'uses root as default destination directory user' do
      expect(chef_run.node['wordpress']['downloader']['destination_dir_owner']).to eq('root')
    end

    it 'uses root as default destination directory group' do
      expect(chef_run.node['wordpress']['downloader']['destination_dir_group']).to eq('root')
    end
  end

  context 'custom attributes context' do
    context 'protocol attribute' do
      %w(http ftp file).each do |protocol|
        it "uses #{protocol.upcase} as custom protocol to download Wordpress" do
          chef_run.node.set['wordpress']['downloader']['protocol'] = protocol
          chef_run.converge(described_recipe)
          expect(chef_run.node['wordpress']['downloader']['protocol']).to eq(protocol)
        end

        it "uses a well formed URI when using #{protocol.upcase} as protocol to download Wordpress" do
          chef_run.node.set['wordpress']['downloader']['protocol'] = protocol
          chef_run.converge(described_recipe)
          source = chef_run.node['wordpress']['downloader']['source']
          source = "/#{source}" if protocol == 'file'
          package_version = chef_run.node['wordpress']['downloader']['package_version']
          package_type = chef_run.node['wordpress']['downloader']['package_type']
          source = "#{protocol}://#{source}/#{package_version}.#{package_type}"
          expect(chef_run).to create_remote_file('./wordpress-latest.zip').with(source: source)
        end
      end
    end

    %w(example.com /local/path).each do |source|
      it "uses a custom source attribute (#{source})" do
        chef_run.node.set['wordpress']['downloader']['source'] = source
        chef_run.converge(described_recipe)
        expect(chef_run.node['wordpress']['downloader']['source']).to eq(source)
      end
    end

    it 'uses a custom package type attribute' do
      chef_run.node.set['wordpress']['downloader']['package_type'] = 'gzip'
      chef_run.converge(described_recipe)
      expect(chef_run.node['wordpress']['downloader']['package_type']).to eq('gzip')
    end

    it 'uses a custom package version attribute' do
      chef_run.node.set['wordpress']['downloader']['package_version'] = 'wordpress-3.2.0'
      chef_run.converge(described_recipe)
      expect(chef_run.node['wordpress']['downloader']['package_version']).to eq('wordpress-3.2.0')
    end

    it 'uses a custom destination filename attribute' do
      chef_run.node.set['wordpress']['downloader']['destination_filename'] = 'my-wordpress-package'
      chef_run.converge(described_recipe)
      expect(chef_run.node['wordpress']['downloader']['destination_filename']).to eq('my-wordpress-package')
    end
  end

  context 'download actions context' do
    it 'downloads Wordpress based on the default attributes' do
      expect(chef_run).to create_remote_file('./wordpress-latest.zip').with(source: 'https://wordpress.org/latest.zip')
    end

    it 'downloads Wordpress by assigning it to root user & group' do
      expect(chef_run).to create_remote_file('./wordpress-latest.zip').with(owner: 'root', group: 'root')
    end

    it 'downloads Wordpress by assigning it to a custom user and group' do
      chef_run.node.set['wordpress']['downloader']['destination_file_owner'] = 'automator'
      chef_run.node.set['wordpress']['downloader']['destination_file_group'] = 'automators'
      chef_run.converge(described_recipe)
      expect(chef_run).to create_remote_file('./wordpress-latest.zip').with(owner: 'automator', group: 'automators')
    end

    it 'downloads Wordpress by using a custom destination filename' do
      chef_run.node.set['wordpress']['downloader']['destination_filename'] = 'my-wordpress-package'
      chef_run.converge(described_recipe)
      expect(chef_run).to create_remote_file('./my-wordpress-package.zip')
    end

    it 'downloads a custom version of Wordpress' do
      chef_run.node.set['wordpress']['downloader']['destination_filename'] = 'wordpress-4.2.2'
      chef_run.node.set['wordpress']['downloader']['package_version'] = 'wordpress-4.2.2'
      chef_run.converge(described_recipe)
      expect(chef_run).to create_remote_file('./wordpress-4.2.2.zip').with(source: 'https://wordpress.org/wordpress-4.2.2.zip')
    end

    it 'downloads the correct package when gzip package type is requested' do
      chef_run.node.set['wordpress']['downloader']['package_type'] = 'gzip'
      chef_run.converge(described_recipe)
      expect(chef_run).to create_remote_file('./wordpress-latest.tar.gz').with(source: 'https://wordpress.org/latest.tar.gz')
    end

    it 'downloads the correct package when iis package type is requested' do
      chef_run.node.set['wordpress']['downloader']['package_type'] = 'iis'
      chef_run.node.set['wordpress']['downloader']['destination_filename'] = 'my-iis-wordpress-instance'
      chef_run.node.set['wordpress']['downloader']['package_version'] = 'wordpress-4.2.2'
      chef_run.converge(described_recipe)
      expect(chef_run).to create_remote_file('./my-iis-wordpress-instance.zip').with(source: 'https://wordpress.org/wordpress-4.2.2-IIS.zip')
    end
  end

  context 'directory actions context' do
    it 'creates the destination directory with root as owner & group assigned by default' do
      expect(chef_run).to create_directory('./').with(owner: 'root', group: 'root')
    end

    it 'creates the destination directory with a custom user and group assigned' do
      chef_run.node.set['wordpress']['downloader']['destination_dir_owner'] =  'automator'
      chef_run.node.set['wordpress']['downloader']['destination_dir_group'] = 'automators'
      chef_run.converge(described_recipe)
      expect(chef_run).to create_directory('./').with(owner: 'automator', group: 'automators')
    end

    it 'creates the destination directory if it does not exist and downloads Wordpress in there' do
      chef_run.node.set['wordpress']['downloader']['destination'] = '/missing/directory/'
      chef_run.converge(described_recipe)
      expect(chef_run).to create_directory('/missing/directory/')
      expect(chef_run).to create_remote_file('/missing/directory/wordpress-latest.zip')
    end
  end
end
