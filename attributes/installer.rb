default['wordpress']['installer']['extraction_destination'] = './'
default['wordpress']['installer']['wp_config_file_mode'] = 0640

default['wordpress']['installer']['wp_config']['db_name'] = ''
default['wordpress']['installer']['wp_config']['db_user'] = ''
default['wordpress']['installer']['wp_config']['db_password'] = ''
default['wordpress']['installer']['wp_config']['db_host'] = 'localhost'
default['wordpress']['installer']['wp_config']['db_charset'] = 'utf8'
default['wordpress']['installer']['wp_config']['db_collate'] = ''
default['wordpress']['installer']['wp_config']['auth_key'] = ''
default['wordpress']['installer']['wp_config']['secure_auth_key'] = ''
default['wordpress']['installer']['wp_config']['logged_in_key'] = ''
default['wordpress']['installer']['wp_config']['nonce_key'] = ''
default['wordpress']['installer']['wp_config']['auth_salt'] = ''
default['wordpress']['installer']['wp_config']['secure_auth_salt'] = ''
default['wordpress']['installer']['wp_config']['logged_in_salt'] = ''
default['wordpress']['installer']['wp_config']['nonce_salt'] = ''
default['wordpress']['installer']['wp_config']['table_prefix'] = 'wp_'
default['wordpress']['installer']['wp_config']['wp_debug'] = false
##
# An hash definition like { 'WP_CONSTANT' => 'value' }
# will translate in a PHP constant definition:
# define('WP_CONSTANT', 'value')
##
default['wordpress']['installer']['wp_config']['additional_values'] = {}
