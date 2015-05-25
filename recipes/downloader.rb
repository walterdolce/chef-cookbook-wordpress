node_attribute = node['wordpress']['downloader']

destination_uri = node_attribute['destination']
filename = "#{node_attribute['destination_filename']}.#{node_attribute['package_type']}"

directory destination_uri do
  user node_attribute['destination_dir_user']
  group node_attribute['destination_dir_group']
  recursive true
  action :create
end

source_uri = node_attribute['protocol'] + '://' + node_attribute['source'] + '/'
source_uri = source_uri + node_attribute['package_version'] + '.' + node_attribute['package_type']

remote_file File.join(destination_uri, filename) do
  source source_uri
  user node_attribute['destination_file_user']
  group node_attribute['destination_file_group']
  action :create
end
