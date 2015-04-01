require_relative 'test_helper'

class ChangelogGeneratorTest < MiniTest::Test
  describe 'changelog generation' do
    before do
      @changelog = ChangelogGenerator::Changelog.new(
        path_to_fixture('old1.packages'),
        path_to_fixture('new1.packages')
      )
      @reporter = ChangelogGenerator::Reporter.new(@changelog)
      Timecop.freeze
    end

    it 'generates a valid report' do
      expected = <<EOE
* #{Time.now.strftime('%a %b %d %Y')} fcastelli@suse.com
- Packages removed:
  * file-magic-5.19-9.1
- Packages added:
  * ca-certificates-1_201403302107-6.2
- Packages upgraded:
  * libuuid1 from version 2.25-10.1 to 3.25-10.1
- Packages downgraded:
  * libgcc_s1 from version 1.8.3+r212056-11.2 to 1.5.3+r212056-11.2

EOE
      assert_equal expected, @reporter.report
    end

    it 'adds the new changelog on top of the old one' do
      old_changelog = <<EOC
-------------------------------------------------------------------
Tue Mar 30 14:46:16 2015 - Flavio Castelli <fcastelli@suse.com>

- First version

EOC
      expected = <<EOE
* #{Time.now.strftime('%a %b %d %Y')} fcastelli@suse.com
- Packages removed:
  * file-magic-5.19-9.1
- Packages added:
  * ca-certificates-1_201403302107-6.2
- Packages upgraded:
  * libuuid1 from version 2.25-10.1 to 3.25-10.1
- Packages downgraded:
  * libgcc_s1 from version 1.8.3+r212056-11.2 to 1.5.3+r212056-11.2

-------------------------------------------------------------------
Tue Mar 30 14:46:16 2015 - Flavio Castelli <fcastelli@suse.com>

- First version

EOE
      assert_equal expected, @reporter.report(old_changelog)
    end
  end
end
