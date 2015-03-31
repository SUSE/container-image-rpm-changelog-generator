require File.expand_path('../../lib/changelog_generator', __FILE__)

require 'minitest/autorun'
require 'timecop'

module MiniTest
  class Test
    def path_to_fixture(name)
      File.expand_path("../fixtures/#{name}", __FILE__)
    end
    def read_fixture(name)
      File.read(path_to_fixture(name))
    end
  end
end
