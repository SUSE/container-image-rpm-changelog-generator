require_relative 'test_helper'

class ChangelogGeneratorTest < MiniTest::Test
  describe 'changelog generation' do
    before do
      @changelog = ChangelogGenerator::Changelog.new(
        old_packages_file: path_to_fixture('old1.packages'),
        new_packages_file: path_to_fixture('new1.packages')
      )
    end

    it 'find new packages installed' do
      assert_equal(['ca-certificates'], @changelog.packages_added)
    end

    it 'find packages deleted' do
      assert_equal(['file-magic'], @changelog.packages_removed)
    end

    it 'find packages upgraded' do
      assert_equal(['libuuid1'], @changelog.packages_changed[:upgraded])
    end

    it 'find packages downgraded' do
      assert_equal(['libgcc_s1'], @changelog.packages_changed[:downgraded])
    end

    it 'ignores unchanged packages' do
      assert(!@changelog.packages_changed[:downgraded].include?('dummy-release'))
      assert(!@changelog.packages_changed[:upgraded].include?('dummy-release'))
      assert(!@changelog.packages_added.include?('dummy-release'))
      assert(!@changelog.packages_removed.include?('dummy-release'))
    end
  end
end
