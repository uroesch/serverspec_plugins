# Serverspec+
Useful serverspec types and matchers that don't necessarily warrant inclusion into upstream

This is a collection of scripts that extend the core functionality of [serverspec](http://serverspec.org).

## Usage
To make use of the serverspec\_plugins collection download or clone the repository add this _require_ statement into your serverspec script

```ruby
require 'serverspec'
require 'serverspec_plus'
```

and issue ```rspec``` with the ```-I``` switch followed by the path to the serverspec\_plugins directory. E.g ```rspec -I /my/path/to/serverspec_plus/lib```.

## Addtional Resources Types
Currently there are only two custom types. More should follow based on my own usage.

### dovecot

The *dovecot* resource type checks the configuration via the ```doveconf``` command. Unlike the upstream [```php_config```](http://serverspec.org/resource_types.html#php_config) where every configuration value query needs to be wrapped into ```describe``` block, only one block is required.

#### Sample

```ruby
describe dovecot do
  it { should have_configuration('service/imap-login/inet_listener/imap/address') }
  it { should have_configuration('service/imap-login/inet_listener/imap/port').with_value(0) }
  it { should have_configuration('service/imap-login/inet_listener/imap/ssl').with_value('no') }
  it { should have_configuration('service/imap-login/inet_listener/imaps/address').with_value('') }
  it { should have_configuration('service/imap-login/inet_listener/imaps/port').with_value(993) }
  it { should have_configuration('service/imap-login/inet_listener/imaps/ssl').with_value('yes') }
end
```

yields


```
Dovecot
  should have configuration "service/imap-login/inet_listener/imap/address"
  should have configuration "service/imap-login/inet_listener/imap/port" with value "0"
  should have configuration "service/imap-login/inet_listener/imap/ssl" with value "no"
  should have configuration "service/imap-login/inet_listener/imaps/address" with value ""
  should have configuration "service/imap-login/inet_listener/imaps/port" with value "993"
  should have configuration "service/imap-login/inet_listener/imaps/ssl" with value "yes"
```

*Note:* Omitting the ```with_value``` matcher the configuration item should yield an empty value.

### owncloud

This is an early draft of an attempt to check owncloud. The only functionality right now is to check for enabled or disabled apps.
To make the module work one has to pass the user owncloud is running under and the directory where the installation can be found.

```ruby
describe owncloud(:user => 'www-data', :directory => '/var/www/owncloud') do
  it { should have_enabled_app('files_pdfviewer') }
  it { should have_enabled_app('ownnote').with_version('1.05') }
  it { should have_disabled_app('user_ldap') }
end
```

yields

```
ownCloud running under user "www-data" with installation "/var/www/owncloud"
  should have enabled app "files_pdfviewer"
  should have enabled app "ownnote" with version "1.05"
  should have disabled app "user_ldap"
```
