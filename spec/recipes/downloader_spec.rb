require 'chefspec'

describe 'chef-cookbook-wordpress::downloader' do

  let(:chef_run) {
    ChefSpec::Runner.new({cookbook_path: '../'}).converge(described_recipe)
  }

  context 'default attributes' do
    it 'uses HTTPS as default protocol to download Wordpress' do
      expect(chef_run.node['wordpress']['downloader']['protocol']).to eq('https')
    end

    it 'uses the default Wordpress site URL as source' do
      expect(chef_run.node['wordpress']['downloader']['source']).to eq('wordpress.org')
    end

    it 'uses the latest Wordpress version as default package to download' do
      expect(chef_run.node['wordpress']['downloader']['package_version']).to eq('latest')
    end

    it 'uses zip as default package type to get' do
      expect(chef_run.node['wordpress']['downloader']['package_type']).to eq('zip')
    end

    it 'uses the current directory as default destination directory to place the package' do
      expect(chef_run.node['wordpress']['downloader']['destination']).to eq('./')
    end

    it 'uses the default destination filename for the package to be downloaded' do
      expect(chef_run.node['wordpress']['downloader']['destination_filename']).to eq('wordpress-latest')
    end
  end

  it 'downloads Wordpress based on the default attributes' do
    expect(chef_run).to create_remote_file('./wordpress-latest.zip')
  end

  it 'downloads Wordpress on the specified directory' do
    chef_run.node.set['wordpress']['downloader']['destination'] = '/custom/path/'
    chef_run.converge(described_recipe)
    expect(chef_run).to create_remote_file('/custom/path/wordpress-latest.zip')
  end
end