default['wordpress']['downloader']['protocol'] = 'https' # https | http | ftp | file
default['wordpress']['downloader']['source'] = 'wordpress.org'
# See https://wordpress.org/download/release-archive/ for all available versions
default['wordpress']['downloader']['package_version'] = 'latest'
default['wordpress']['downloader']['package_type'] = 'zip' # zip | gzip | iis
default['wordpress']['downloader']['destination'] = './'
default['wordpress']['downloader']['destination_filename'] = 'wordpress-latest'
default['wordpress']['downloader']['destination_dir_owner'] = 'root'
default['wordpress']['downloader']['destination_dir_group'] = 'root'
default['wordpress']['downloader']['destination_file_owner'] = 'root'
default['wordpress']['downloader']['destination_file_group'] = 'root'
