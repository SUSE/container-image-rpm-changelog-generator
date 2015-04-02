require 'csv'
require 'erb'
require 'optparse'
require 'ostruct'

require File.expand_path('../changelog_generator/rpm/version', __FILE__)
require File.expand_path('../changelog_generator/changelog', __FILE__)
require File.expand_path('../changelog_generator/options', __FILE__)
require File.expand_path('../changelog_generator/reporter', __FILE__)
