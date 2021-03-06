require 'spec_helper'

describe 'chef-cookbook-wordpress::installer' do
  let(:chef_run) do
    allow_any_instance_of(Chef::Mixin::Checksum).to receive(:checksum)
      .with('./wordpress-latest.zip')
      .and_return('checksum')
    ChefSpec::SoloRunner.new(cookbook_path: '../', step_into: ['chef_cookbook_wordpress_archive']) do |node|
      node.set['wordpress']['installer']['downloaded_archive'] = './wordpress-latest.zip'
      node.set['wordpress']['installer']['extraction_destination'] = './my-extraction-directory'
    end.converge(described_recipe)
  end

  it 'run the archive lwrp' do
    expect(chef_run).to extract_archive('./wordpress-latest.zip')
  end

  it 'does nothing when the archive was not downloaded or the attribute set' do
    allow(File).to receive(:exist?).with(anything).and_return(false)
    expect(chef_run).not_to run_execute('Extract downloaded archive')
  end

  it 'installs unzip package when not available on the node' do
    allow(File).to receive(:exist?).with(anything).and_return(true)
    expect(chef_run).to install_package('unzip')
  end

  it 'does not install unzip package when already available on the node' do
    chef_run.package('unzip')
    allow(File).to receive(:exist?).with(anything).and_return(true)
    expect(chef_run).to_not install_package('unzip')
  end

  it 'creates the extraction destination directory if it does not exist' do
    allow(File).to receive(:exist?).with(anything).and_return(true)
    allow(File).to receive(:exist?).with('./checksum').and_return(false)
    expect(chef_run).to create_directory('./my-extraction-directory/')
                          .with(mode: '0755', owner: 'root', group: 'root')
  end

  it 'installs wp-config.php template file' do
    allow(File).to receive(:exist?).with(anything).and_return(true)
    allow(File).to receive(:exist?).with('./checksum').and_return(false)
    expect(chef_run).to create_template('Create/Update wp-config.php file')
                          .with(mode: '0640', owner: 'root', group: 'root')
  end

  context 'handling tar archive package type' do
    let(:chef_run) do
      allow_any_instance_of(Chef::Mixin::Checksum).to receive(:checksum)
        .with('./wordpress-latest.tar.gz')
        .and_return('checksum')
      ChefSpec::SoloRunner.new(cookbook_path: '../', step_into: ['chef_cookbook_wordpress_archive']) do |node|
        node.set['wordpress']['installer']['downloaded_archive'] = './wordpress-latest.tar.gz'
      end.converge(described_recipe)
    end

    it 'run the archive lwrp' do
      expect(chef_run).to extract_archive('./wordpress-latest.tar.gz')
    end

    it 'installs tar package when not available on the node' do
      allow(File).to receive(:exist?).with(anything).and_return(true)
      expect(chef_run).to install_package('tar')
    end

    it 'does not install tar package when already available on the node' do
      chef_run.package('tar')
      allow(File).to receive(:exist?).with(anything).and_return(true)
      expect(chef_run).to_not install_package('tar')
    end

    it 'creates the archive file flag after the archive has been extracted' do
      allow(File).to receive(:exist?).with(anything).and_return(true)
      allow(File).to receive(:exist?).with('./checksum').and_return(false)
      expect(chef_run).to create_file('./checksum')
    end

    it 'extracts the archive once it has been downloaded' do
      allow(File).to receive(:exist?).with(anything).and_return(true)
      allow(File).to receive(:exist?).with('./checksum').and_return(false)
      expect(chef_run).to run_execute('Extract downloaded archive')
    end

    it 'does not extract the archive when the archive checksum file flag is available' do
      expect(chef_run).not_to run_execute('Extract downloaded archive')
    end
  end

  context 'custom wp-config.php template' do
    let(:chef_run) do
      allow_any_instance_of(Chef::Mixin::Checksum).to receive(:checksum)
        .with('./wordpress-latest.zip').and_return('checksum')

      ChefSpec::SoloRunner.new(cookbook_path: '../', step_into: ['chef_cookbook_wordpress_archive']) do |node|
        node.set['wordpress']['installer']['downloaded_archive'] = './wordpress-latest.zip'
        node.set['wordpress']['installer']['wp_config_file_cookbook_source'] = 'another-cookbook'
        node.set['wordpress']['installer']['wp_config_file_owner'] = 'another-owner'
        node.set['wordpress']['installer']['wp_config_file_group'] = 'another-group'
        node.set['wordpress']['installer']['wp_config_file_mode'] = '0777'
      end.converge(described_recipe)
    end
    it 'installs wp-config.php template file with custom attributes' do
      allow(File).to receive(:exist?).with(anything).and_return(true)
      expect(chef_run).to create_template('Create/Update wp-config.php file')
        .with(mode: '0777', owner: 'another-owner', group: 'another-group', cookbook: 'another-cookbook')
    end
  end
end
