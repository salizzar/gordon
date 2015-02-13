require 'optparse'

module Gordon
  class CLI
    def self.run
      options = Options.new
      options.app_source_dir = Dir.pwd
      options.output_dir = Dir.pwd

      parser = create_option_parser(options)
      parser.parse!

      recipe = Recipe.new(options)
      cooker = Cooker.new(recipe)
      cooker.cook
    end

    def self.create_option_parser(options)
      parser = OptionParser.new do |opts|
        opts.banner = 'Usage: gordon [options]'

        opts.on('-T', '--app-type APP_TYPE', 'Application Type') do |app_type|
          options.app_type = app_type
        end

        opts.on('-N', '--app-name APP_NAME', 'Application Name') do |app_name|
          options.app_name = app_name
        end

        opts.on('-D', '--app-desc APP_DESC', 'Application Description') do |app_desc|
          options.app_desc = app_desc
        end

        opts.on('-R', '--app-repo APP_REPO', 'Application Repository URL') do |app_repo|
          options.app_repo = app_repo
        end

        opts.on('-V', '--app-version APP_VERSION', 'Application Version') do |app_version|
          options.app_version = app_version
        end

        opts.on('-S', '--app-source-dir APP_SOURCE_DIR', 'Application Source Directory') do |app_source_dir|
          options.app_source_dir = app_source_dir
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

