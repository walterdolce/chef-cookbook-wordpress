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
  end

end