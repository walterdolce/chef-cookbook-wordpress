require 'serverspec'

set :backend, :exec

describe file('/mydownloadfolder') do
  it { should be_a_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/mydownloadfolder/wordpress-latest.zip') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
