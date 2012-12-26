# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'command_line_email/version'

Gem::Specification.new do |gem|
  gem.name          = "command_line_email"
  gem.version       = CommandLineEmail::VERSION
  gem.authors       = ["James Lavin"]
  gem.email         = ["command_line_email@futureresearch.com"]
  gem.description   = %q{Send email from the Linux or Mac command line}
  gem.summary       = %q{Send email from the Linux or Mac command line. Can attach specific files or all files in a directory. Can load email body from a file.}
  gem.homepage      = "https://github.com/JamesLavin/command_line_email"

  gem.files         = `git ls-files`.split($/)
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'fakefs'
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
