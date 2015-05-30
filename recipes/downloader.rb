downloader = node['wordpress']['downloader']
file_uri = File.join(
  downloader['destination'],
  "#{downloader['destination_filename']}.#{downloader['package_type']}"
)
source = (downloader['protocol'] == 'file') ? "/#{downloader['source']}" : downloader['source']

directory downloader['destination'] do
  user downloader['destination_dir_user']
  group downloader['destination_dir_group']
  recursive true
  action :create
end

remote_file file_uri do
  source "#{downloader['protocol']}://#{source}/#{downloader['package_version']}.#{downloader['package_type']}"
  user downloader['destination_file_user']
  group downloader['destination_file_group']
  action :create
end
