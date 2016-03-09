require 'serverspec'
require 'serverspec_plus'

set :backend, :exec

describe dovecot do
  it { should have_configuration('service/imap-login/inet_listener/imap/address') }
  it { should have_configuration('service/imap-login/inet_listener/imap/port').with_value(0) }
  it { should have_configuration('service/imap-login/inet_listener/imap/ssl').with_value('no') }
  it { should have_configuration('service/imap-login/inet_listener/imaps/address').with_value('') }
  it { should have_configuration('service/imap-login/inet_listener/imaps/port').with_value(993) }
  it { should have_configuration('service/imap-login/inet_listener/imaps/ssl').with_value('yes') }
end
