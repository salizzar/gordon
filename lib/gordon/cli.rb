require 'optparse'

module Gordon
  class CLI
    def self.run
      options = Options.new
      options.app_source = Dir.pwd
      options.output_dir = Dir.pwd

      parser = create_option_parser(options)
      parser.parse!

      recipes = Cookbook.exists? ? Cookbook.read_and_merge_with(options) : [ Recipe.new(options) ]
      cooker = Cooker.new(recipes)
      cooker.cook
    end

    def self.create_option_parser(options)
      parser = OptionParser.new do |opts|
        opts.banner = 'Usage: gordon [options]'

        opts.on('-N', '--app-name APP_NAME', 'Application Name') do |app_name|
          options.app_name = app_name
        end

        opts.on('-D', '--app-description APP_DESCRIPTION', 'Application Description') do |app_description|
          options.app_description = app_description
        end

        opts.on('-G', '--app-homepage APP_HOMEPAGE', 'Application Homepage') do |app_homepage|
          options.app_homepage = app_homepage
        end

        opts.on('-V', '--app-version APP_VERSION', 'Application Version') do |app_version|
          options.app_version = app_version
        end

        opts.on('-S', '--app-source APP_SOURCE', 'Application Source') do |app_source|
          options.app_source = app_source
        end

        opts.on('-E', '--app-source-excludes APP_SOURCE_EXCLUDES', 'Application Source Excludes List') do |app_source_excludes|
          options.app_source_excludes = app_source_excludes
        end

        opts.on('-T', '--app-type APP_TYPE', 'Application Type') do |app_type|
          options.app_type = app_type
        end

        opts.on('-X', '--runtime-name RUNTIME_NAME', 'Runtime Name') do |runtime_name|
          options.runtime_name = runtime_name
        end

        opts.on('-R', '--runtime-version RUNTIME_VERSION', 'Runtime Version') do |runtime_version|
          options.runtime_version = runtime_version
        end

        opts.on('-H', '--http-server-type HTTP_SERVER_TYPE', 'HTTP Server Type') do |http_server_type|
          options.http_server_type = http_server_type
        end

        opts.on('-W', '--web-server-type WEB_SERVER_TYPE', 'Web Server Type') do |web_server_type|
          options.web_server_type = web_server_type
        end

        opts.on('-I', '--init-type INIT_TYPE', 'Init Type') do |init_type|
          options.init_type = init_type
        end

        opts.on('-P', '--package-type PACKAGE', 'Package type') do |package_type|
          options.package_type = package_type
        end

        opts.on('-O', '--output-dir OUTPUT_DIR', 'Output Directory') do |output_dir|
          options.output_dir = output_dir
        end

        opts.on('-d', '--debug', 'Debug Mode') do |debug|
          options.debug = debug
        end

        opts.on('-t', '--trace', 'Trace Mode') do |trace|
          options.trace = trace
        end

        opts.on('-h', '--help', 'Displays Help') do
          puts opts
          exit
        end

        opts.on('-v', '--version', 'Displays Version') do
          puts VERSION
          exit
        end
      end

      parser
    end
  end
end

