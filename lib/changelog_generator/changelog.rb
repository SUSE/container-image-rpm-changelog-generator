module ChangelogGenerator
  class Changelog
    attr_reader :old_packages, :new_packages

    def initialize(old_packages_file, new_packages_file)
      @old_packages = parse_kiwi_packages_file(old_packages_file)
      @new_packages = parse_kiwi_packages_file(new_packages_file)
    end

    def packages_added
      return @packages_added if @packages_added
      @packages_added = @new_packages.keys - @old_packages.keys
    end

    def packages_removed
      return @packages_removed if @packages_removed
      @packages_removed = @old_packages.keys - @new_packages.keys
    end

    def packages_changed
      return @packages_changed if @packages_changed

      common_pkgs = @old_packages.keys & @new_packages.keys

      updated = common_pkgs.find_all do |name|
        @new_packages[name] > @old_packages[name]
      end

      downgraded = common_pkgs.find_all do |name|
        @new_packages[name] < @old_packages[name]
      end

      @packages_changed = {
        :upgraded => updated,
        :downgraded => downgraded
      }
    end

    def parse_kiwi_packages_file(file)
      packages = {}

      if file && File.exist?(file)
        if Gem::Version.new(RUBY_VERSION) < Gem::Version.new('1.9.0')
          csv = FasterCSV.open(file, :col_sep => '|')
        else
          csv = CSV.open(file, :col_sep => '|')
        end
 
        csv.readlines.each do |row|
          name    = row[0]
          epoch   = row[1]
          version = row[2]
          release = row[3]

          epoch = epoch.to_i if epoch

          packages[name] = RPM::Version.new(version, release, epoch)
        end
      end

      packages
    end

  end
end
