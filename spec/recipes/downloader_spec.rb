require 'chefspec'

describe 'chef-cookbook-wordpress::downloader' do

  let(:chef_run) {
    ChefSpec::Runner.new({cookbook_path: '../'}).converge(described_recipe)
  }

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
  end

  context 'custom attributes context' do
    context 'protocol attribute' do
      %w(http ftp file).each do |protocol|
        it "uses #{protocol.upcase} as custom protocol to download Wordpress" do
          chef_run.node.set['wordpress']['downloader']['protocol'] = protocol
          chef_run.converge(described_recipe)
          expect(chef_run.node['wordpress']['downloader']['protocol']).to eq(protocol)
        end
      end
    end
    context 'package type attribute' do
      %w(gzip iis).each do |package_type|
        it "uses #{package_type.upcase} as custom package type to download" do
          chef_run.node.set['wordpress']['downloader']['package_type'] = package_type
          chef_run.converge(described_recipe)
          expect(chef_run.node['wordpress']['downloader']['package_type']).to eq(package_type)
        end
      end
    end
  end

  context 'download actions context' do
    it 'downloads Wordpress based on the default attributes' do
      expect(chef_run).to create_remote_file('./wordpress-latest.zip')
    end

    it 'downloads Wordpress on the specified directory' do
      chef_run.node.set['wordpress']['downloader']['destination'] = '/custom/path/'
      chef_run.converge(described_recipe)
      expect(chef_run).to create_remote_file('/custom/path/wordpress-latest.zip')
    end
  end

  context 'directory actions context' do
    it 'creates the destination directory if it does not exist' do
      chef_run.node.set['wordpress']['downloader']['destination'] = '/missing/directory/'
      chef_run.converge(described_recipe)
      expect(chef_run).to create_directory('/missing/directory/')
    end
  end
end