downloader = node['wordpress']['downloader']

destination_uri = downloader['destination']
filename = "#{downloader['destination_filename']}.#{downloader['package_type']}"
source = downloader['source']
source = "/#{source}" if downloader['protocol'] == 'file'

directory destination_uri do
  user downloader['destination_dir_user']
  group downloader['destination_dir_group']
  recursive true
  action :create
end

source_uri = downloader['protocol'] + '://' + source + '/'
source_uri = source_uri + downloader['package_version'] + '.' + downloader['package_type']

remote_file File.join(destination_uri, filename) do
  source source_uri
  user downloader['destination_file_user']
  group downloader['destination_file_group']
  action :create
end
