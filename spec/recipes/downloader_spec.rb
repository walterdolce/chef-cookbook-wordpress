require 'chefspec'

describe 'chef-cookbook-wordpress::downloader' do

  let(:chef_run) {
    ChefSpec::Runner.new({cookbook_path: '../'}).converge(described_recipe)
  }

  it 'uses HTTPS as default protocol to download Wordpress' do
    expect(chef_run.node['wordpress']['downloader']['protocol']).to eq('https')
  end

end