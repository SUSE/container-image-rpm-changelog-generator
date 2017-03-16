if Gem::Version.new(RUBY_VERSION) < Gem::Version.new('1.9.0')
  require 'fastercsv'
else
  require 'csv'
end
require 'erb'
require 'optparse'
require 'ostruct'
require 'rpm'

require File.expand_path('../changelog_generator/changelog', __FILE__)
require File.expand_path('../changelog_generator/options', __FILE__)
require File.expand_path('../changelog_generator/reporter', __FILE__)
