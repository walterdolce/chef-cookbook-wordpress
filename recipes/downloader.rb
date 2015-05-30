downloader = node['wordpress']['downloader']
package_type = (downloader['package_type'] == 'gzip') ? 'tar.gz' : downloader['package_type']
filename = downloader['destination_filename']
package_type = 'zip' if downloader['package_type'] == 'iis'
package_version = downloader['package_version']
filename = "#{filename}-IIS" if downloader['package_type'] == 'iis'
package_version = "#{package_version}-IIS" if downloader['package_type'] == 'iis'

file_uri = File.join(
  downloader['destination'],
  "#{filename}.#{package_type}"
)
source = (downloader['protocol'] == 'file') ? "/#{downloader['source']}" : downloader['source']

directory downloader['destination'] do
  user downloader['destination_dir_user']
  group downloader['destination_dir_group']
  recursive true
  action :create
end

remote_file file_uri do
  source "#{downloader['protocol']}://#{source}/#{package_version}.#{package_type}"
  user downloader['destination_file_user']
  group downloader['destination_file_group']
  action :create
end
