# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'serverspec_plus/version'

Gem::Specification.new do |spec|
  spec.name          = 'serverspec_plus'
  spec.version       = ServerspecPlus::VERSION
  spec.authors       = ['Urs Roesch']
  spec.email         = ['github@bun.ch']
  spec.description   = %(Additional domain specific serverspec types ) +
                       %(that don't warrant inclusion into upstream)
  spec.summary       = %(Additional domain specific serverspec types)
  spec.homepage      = 'https://github.com/uroesch/serverspec_plus/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($RS)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'serverspec', '~> 2.30'
end
