require 'spec_helper'

describe 'chef-cookbook-wordpress::installer' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(cookbook_path: '../').converge(described_recipe)
  end

  it 'does nothing when the archive was not downloaded or the attribute set' do
    expect(chef_run).not_to run_execute('Extract downloaded archive')
  end

  it 'installs unzip package when not available on the node' do
    chef_run.node.set['wordpress']['installer']['downloaded_archive'] = '/wordpress-latest.zip'
    allow(File).to receive(:exist?).with(anything).and_return(true)
    chef_run.converge(described_recipe)
    expect(chef_run).to install_package('unzip')
  end

  it 'installs tar package when not available on the node' do
    chef_run.node.set['wordpress']['installer']['downloaded_archive'] = '/wordpress-latest.tar.gz'
    allow(File).to receive(:exist?).with(anything).and_return(true)
    chef_run.converge(described_recipe)
    expect(chef_run).to install_package('tar')
  end

  it 'does not install unzip package when already available on the node' do
    chef_run.node.set['wordpress']['installer']['downloaded_archive'] = '/wordpress-latest.zip'
    chef_run.package('unzip')
    allow(File).to receive(:exist?).with(anything).and_return(true)
    chef_run.converge(described_recipe)
    expect(chef_run).to_not install_package('unzip')
  end

  it 'does not install tar package when already available on the node' do
    chef_run.node.set['wordpress']['installer']['downloaded_archive'] = '/wordpress-latest.tar.gz'
    chef_run.package('tar')
    allow(File).to receive(:exist?).with(anything).and_return(true)
    chef_run.converge(described_recipe)
    expect(chef_run).to_not install_package('tar')
  end

  it 'extracts the archive in the current directory by default' do
    chef_run.node.set['wordpress']['installer']['downloaded_archive'] = '/wordpress-latest.zip'
    allow(File).to receive(:exist?).with(anything).and_return(true)
    chef_run.converge(described_recipe)
    expect(chef_run).to run_execute('Extract downloaded archive')
    expect(chef_run.node['wordpress']['installer']['extraction_destination']).to eq('./')
  end
end
