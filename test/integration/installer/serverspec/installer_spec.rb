require 'serverspec'

set :backend, :exec

describe file('/mydownloadfolder/myextractionfolder/') do
  it { should be_a_directory }
  it { should be_owned_by 'vagrant' }
  it { should be_grouped_into 'vagrant' }
end

describe file('/mydownloadfolder/myextractionfolder/wp-config.php') do
  it { should be_file }
  it { should be_owned_by 'vagrant' }
  it { should be_grouped_into 'vagrant' }
  it { should be_mode 777 }

  its(:content) {
    should match /define\('DB_NAME', 'mydbname'\);/
    should match /define\('DB_USER', 'mydbuser'\)/
    should match /define\('DB_PASSWORD', 'mydbpassword'\)/
    should match /define\('DB_HOST', 'mydbhostname'\)/
    should match /define\('DB_CHARSET', 'mydbcharset'\)/
    should match /define\('DB_COLLATE', 'mydbcollate'\)/
    should match /define\('DB_NAME', 'mydbname'\)/
    should match /define\('DB_USER', 'mydbuser'\)/
    should match /define\('DB_PASSWORD', 'mydbpassword'\)/
    should match /define\('DB_HOST', 'mydbhostname'\)/
    should match /define\('DB_CHARSET', 'mydbcharset'\)/
    should match /define\('DB_COLLATE', 'mydbcollate'\)/
    should match /define\('AUTH_KEY',         'myauthkey'\)/
    should match /define\('SECURE_AUTH_KEY',  'mysecureauthkey'\)/
    should match /define\('LOGGED_IN_KEY',    'myloggedinkey'\)/
    should match /define\('NONCE_KEY',        'mynoncekey'\)/
    should match /define\('AUTH_SALT',        'myauthsalt'\)/
    should match /define\('SECURE_AUTH_SALT', 'mysecureauthsalt'\)/
    should match /define\('LOGGED_IN_SALT',   'myloggedinsalt'\)/
    should match /define\('NONCE_SALT',       'mynoncesalt'\)/
    should match /\$table_prefix  = 'mytableprefix_';/
    should match /define\('WP_DEBUG', true\);/
    should match /define\('param1', 'myparamstring'\)/
    should match /define\('param2', true\);/
    should match /define\('param3', 123\);/
    should match /define\('param4', 123\.123\);/
  }
end
