class Options

  # Return a structure describing the options.
  def self.parse(args)
    # The options specified on the command line will be collected in *options*.
    # We set default values here.
    options = OpenStruct.new
    options.old_packages  = nil
    options.old_changelog = nil

    opt_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: changelog-generator [options]'

      opts.separator ''
      opts.separator 'Specific options:'

      opts.on('-n', '--new-packages NEW_PACKAGES',
              'New ".packages" file created by KIWI') do |file|
        options.new_packages = file
      end

      opts.on('-o', '--old-packages [OLD_PACKAGES]',
              'Old ".packages" file created by KIWI') do |file|
        options.old_packages = file
      end

      opts.on('-c', '--changelog [OLD_CHANGELOG]',
              'Old changelog file to extend') do |file|
        options.old_changelog = file
      end

      opts.separator ''
      opts.separator 'Common options:'

      opts.on_tail('-h', '--help', 'Show this message') do
        puts opts
        exit
      end
    end

    opt_parser.parse!(args)

    raise OptionParser::MissingArgument unless options.new_packages

    options
  end

end
