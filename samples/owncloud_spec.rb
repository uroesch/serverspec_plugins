require 'serverspec'
require 'serverspec_plus'

set :backend, :exec

describe owncloud(:user => 'www-data', :directory => '/var/www/owncloud') do
  it { should have_configuration('dbtype').with_value('pgsql') }
  it { should have_configuration('version').with_value('8.2.2.2') }
  it { should have_configuration('dbname').with_value('owncloud') }
  it { should have_configuration('dbhost').with_value('localhost') }
  it { should have_enabled_app('files_pdfviewer') }
  it { should have_enabled_app('ownnote').with_version('1.05') }
  it { should have_disabled_app('user_ldap') }
end
