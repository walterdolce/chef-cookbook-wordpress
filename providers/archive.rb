include Chef::Mixin::Checksum

provides :archive
provides :package
provides :directory
provides :execute
provides :file
provides :template

def whyrun_supported?
  true
end

use_inline_resources

action :extract do
  converge_by("Handle archive #{new_resource}") do
    archive = node[:wordpress][:installer][:downloaded_archive]
    archive_type = archive.split('.')

    if archive_type.is_a?(Array) && ::File.exist?(archive)
      archive_type = archive_type.last
      archive_dir = "#{::File.dirname(archive).gsub(%r{/+$}, '')}/"

      case archive_type
        when 'gz' # part of .tar.gz
          extractor = 'tar'
          extraction_options = '-xvf'
          extraction_destination_option = '-C'
        else
          extractor = 'unzip'
          extraction_options = ''
          extraction_destination_option = '-d'
      end

      package extractor

      destination = node['wordpress']['installer']['extraction_destination']
      destination = "#{destination.gsub(%r{/+$}, '')}/"

      directory destination do
        owner node['wordpress']['installer']['extraction_destination_dir_owner']
        group node['wordpress']['installer']['extraction_destination_dir_group']
        mode node['wordpress']['installer']['extraction_destination_dir_mode']
        recursive true
        action :create
      end


      checksum = checksum(archive)
      checksum_file = "#{archive_dir}#{checksum}"
      Chef::Log.debug "Checksum for #{archive} is --> #{checksum}"

      if ::File.exist?(checksum_file)
        Chef::Log.debug "Checksum file #{checksum_file} already exists - nothing to do"
      else
        execute 'Extract downloaded archive' do
          command "#{extractor} #{extraction_options} #{archive} #{extraction_destination_option} #{destination}"
        end
      end

      file checksum_file do
        action :create
      end

      template 'Create/Update wp-config.php file' do
        path "#{destination}wp-config.php"
        source 'wp-config.php.erb'
        group node['wordpress']['installer']['wp_config_file_group']
        owner node['wordpress']['installer']['wp_config_file_owner']
        mode node['wordpress']['installer']['wp_config_file_mode']
        action :create
        cookbook node['wordpress']['installer']['wp_config_file_cookbook_source']
      end
    else
      Chef::Log.debug("#{archive} does not exists or could not be processed - nothing to do")
    end
    new_resource.updated_by_last_action(true)
  end
end
