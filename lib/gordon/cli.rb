require 'optparse'

module Gordon
  class CLI
    def self.run
      options = Options.new
      options.source_dir      = Dir.pwd
      options.build_dir       = '/tmp'
      options.package_dir     = Dir.pwd
      options.init_build_dir  = '/tmp'

      parser = create_option_parser(options)
      parser.parse!

      file_path = File.join(Dir.pwd, 'gordon.yml')

      recipe = Recipe.new(options)
      cooker = Cooker.new(recipe, options)
      cooker.cook
    end

    def self.create_option_parser(options)
      parser = OptionParser.new do |opts|
        opts.banner = 'Usage: gordon [options]'

        opts.on('-t', '--app-type APP_TYPE', 'Application Type') do |type|
          options.app_type = type
        end

        opts.on('-n', '--app-name APP_NAME', 'Application Name') do |name|
          options.app_name = name
        end

        opts.on('-d', '--app-desc APP_DESC', 'Application Description') do |desc|
          options.app_desc = desc
        end

        opts.on('-r', '--app-repo APP_REPO', 'Application Repository URL') do |repo|
          options.app_repo = repo
        end

        opts.on('-V', '--app-version APP_VERSION', 'Application Version') do |version|
          options.app_version = version
        end

        opts.on('-p', '--package-type PACKAGE', 'Package type') do |package_type|
          options.package_type = package_type
        end

        opts.on('-P' '--package-dir PACKAGE_DIR', 'Package Directory') do |package_dir|
          options.package_dir = package_dir
        end

        opts.on('-s', '--source-dir SOURCE_DIR', 'Source Directory') do |source_dir|
          options.source_dir = source_dir
        end

        opts.on('-b', '--build-dir BUILD_DIR', 'Build Directory') do |build_dir|
          options.build_dir = build_dir
        end

        opts.on('-S', '--skeleton-type SKELETON_TYPE', 'Skeleton Type') do |skeleton_type|
          options.skeleton_type = skeleton_type
        end

        opts.on('-i', '--init-type INIT_TYPE', 'Init Type') do |init_type|
          options.init_type = init_type
        end

        opts.on('-I', '--init-build-dir INIT_BUILD_DIR', 'Init Build Directory') do |init_build_dir|
          options.init_build_dir = init_build_dir
        end

        opts.on('-D', '--debug DEBUG', 'Debug Mode') do |debug|
          options.debug = debug
        end

        opts.on('-h', '--help', 'Displays Help') do
          puts opts
          exit
        end
      end

      parser
    end
  end
end

