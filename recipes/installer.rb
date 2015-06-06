
if node[:wordpress].attribute?(:installer) && node[:wordpress][:installer].attribute?(:downloaded_archive)
  archive = node[:wordpress][:installer][:downloaded_archive]
  archive_type = archive.split('.')

  if archive_type.is_a?(Array) && ::File.exist?(archive)
    archive_type = archive_type.last
    case archive_type
    when 'gz' # part of .tar.gz
      extractor = 'tar'
      extraction_options = '-xvf'
      extraction_destination_option = '-d'
    else
      extractor = 'unzip'
      extraction_options = ''
      extraction_destination_option = '-C'
    end

    package extractor

    destination = node['wordpress']['installer']['extraction_destination']

    ::Chef::Recipe.send(:include, Chef::Mixin::Checksum)
    checksum = checksum(archive)

    execute 'Extract downloaded archive' do
      command "#{extractor} #{extraction_options} #{archive} #{extraction_destination_option} #{destination}"
      not_if { ::File.exist?("#{destination.gsub(%r{/+$}, '')}/#{checksum}") }
    end
  end
end
