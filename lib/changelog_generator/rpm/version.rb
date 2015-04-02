module ChangelogGenerator
  module RPM
    class Version
      attr_reader :version, :release, :epoch

      include Comparable

      COMPARISON_HELPER = File.expand_path('../../../bin/rpmdev-vercmp', __FILE__)

      def initialize(version, release, epoch)
        @version = version
        @release = release
        @epoch   = epoch
      end

      def <=>(another)
        `#{COMPARISON_HELPER} #{@epoch} #{@version} #{@release} #{another.epoch} #{another.version} #{another.release}`
        case $?.exitstatus
        when 0
          return 0
        when 11
          return 1
        when 12
          return -1
        else
          raise "Error while invoking external command"
        end
      end

      def to_s
        @release.nil? ? "#{@version}" : "#{@version}-#{@release}"
      end
    end
  end
end
