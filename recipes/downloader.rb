downloader = node['wordpress']['downloader']

if downloader['package_version'] == 'latest' && downloader['package_type'] == 'iis'
  raise '
  The requested package version & type (latest + iis) is not available.
  If you want to download the latest Wordpress IIS package version
  you must to explicitly specify it in the attributes.'
end

case downloader['package_type']
when 'gzip'
  package_type = 'tar.gz'
else
  package_type = 'zip'
end
package_version = downloader['package_version']
package_version = "#{package_version}-IIS" if downloader['package_type'] == 'iis'
source = (downloader['protocol'] == 'file') ? "/#{downloader['source']}" : downloader['source']

directory downloader['destination'] do
  user downloader['destination_dir_user']
  group downloader['destination_dir_group']
  recursive true
  action :create
end

file_uri = File.join(downloader['destination'], "#{downloader['destination_filename']}.#{package_type}")

remote_file 'Download Wordpress package' do
  path file_uri
  source "#{downloader['protocol']}://#{source}/#{package_version}.#{package_type}"
  user downloader['destination_file_user']
  group downloader['destination_file_group']
  action :create
end

node.set['wordpress']['installer']['downloaded_archive'] = file_uri
