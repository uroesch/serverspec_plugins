require 'serverspec'
require 'serverspec_plus'

set :backend, :exec

describe owncloud(:user => 'www-data', :directory => '/var/www/owncloud') do
  it { should have_enabled_app('files_pdfviewer') }
  it { should have_enabled_app('ownnote').with_version('1.05') }
  it { should have_disabled_app('user_ldap') }
end
