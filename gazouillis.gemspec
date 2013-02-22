# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'gazouillis/version'

Gem::Specification.new do |s|
  s.name          = "gazouillis"
  s.version       = Gazouillis::VERSION
  s.authors       = ["chatgris"]
  s.email         = ["jboyer@af83.com"]
  s.homepage      = "http://chatgris.github.com/gazouillis"
  s.summary       = "Twitter stream client."
  s.description   = "Twitter stream client."
  s.files         = `git ls-files lib LICENSE README.md`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.add_dependency "celluloid-io"
  s.add_dependency "http_parser.rb"
  s.add_dependency "simple_oauth"
end
