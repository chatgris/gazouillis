# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'gazouillis/version'

Gem::Specification.new do |s|
  s.name          = "gazouillis"
  s.version       = Gazouillis::VERSION
  s.authors       = ["chatgris"]
  s.email         = ["jboyer@af83.com"]
  s.homepage      = "https://github.com/chatgris/gazouillis"
  s.summary       = "Twitter stream client."
  s.description   = "Twitter stream client."

  s.files         = `git ls-files lib`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.add_dependency "celluloid-io"
end
