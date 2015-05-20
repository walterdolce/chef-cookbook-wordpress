

destination = File.join(
    node['wordpress']['downloader']['destination'],
    node['wordpress']['downloader']['destination_filename'] + '.' + node['wordpress']['downloader']['package_type']
)

remote_file destination do
  source node['wordpress']['downloader']['protocol'] + 
             '://' + 
             node['wordpress']['downloader']['source'] + 
             '/' +
             node['wordpress']['downloader']['package_version'] + 
             '.' + 
             node['wordpress']['downloader']['package_type']
  action :create
end