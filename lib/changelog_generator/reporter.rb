module ChangelogGenerator
  # Class creating contents of the '.changes' file
  class Reporter
    def initialize(changelog)
      @changelog = changelog
    end

    def report(old_changelog_entries=nil)
      ERB.new(
        File.read(
          File.join(
            File.expand_path('../../templates', __FILE__),
            'changes.erb'
          )
        ),
        nil,
        '<>'
      ).result(binding)
    end
  end
end
