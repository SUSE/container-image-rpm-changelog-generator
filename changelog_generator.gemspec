# -*- encoding: utf-8 -*-

require File.expand_path('../lib/changelog_generator/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'changelog_generator'
  s.version     = ChangelogGenerator::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Flavio Castelli']
  s.email       = ['fcastelli@suse.com']
  s.summary     = 'Create changelog for SLE images for Docker'

  s.description = <<EOD
A tool to generate Docker images changelog starting from the .packages
files created by kiwi.
EOD
  s.licenses    = ['MIT']

  s.required_rubygems_version = '>= 1.3.6'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'timecop'
  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map do |f|
    f =~ /^bin\/(.*)/ ? $1 : nil
  end.compact
  s.require_path = 'lib'
end
