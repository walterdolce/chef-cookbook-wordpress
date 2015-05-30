require 'serverspec'

set :backend, :exec

describe file('/wordpress-latest.zip') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
