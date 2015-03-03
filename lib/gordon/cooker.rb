require 'fileutils'

module Gordon
  class Cooker
    attr_reader :recipe, :options

    FPM_COOKERY_COMMAND     = 'fpm-cook'
    FPM_COOKERY_WORKING_DIR = '/tmp/gordon'

    def initialize(recipe)
      @recipe = recipe
      @options = recipe.options
    end

    def cook
      clean
      package
    end

    private

    def clean
      # fpm-cook clean command only cleans tmp-build and tmp-dest folders
      # and don't include cache dir :(
      FileUtils.rm_rf(get_working_path)
    end

    def package
      cook_args = get_command_args

      cook_args << "package"
      cook_args << recipe.application_template_path

      execute(cook_args)
    end

    def get_working_path
      app_path = File.expand_path(options.app_source)
      app_name = File.basename(app_path)
      tmp_path = File.join(FPM_COOKERY_WORKING_DIR, app_name)

      tmp_path
    end

    def get_command_args
      cook_args = []

      cook_args << "--debug"    if options.debug

      cook_args << "--target #{options.package_type}"
      cook_args << "--pkg-dir #{File.expand_path(options.output_dir)}"
      cook_args << "--cache-dir #{File.expand_path(get_working_path)}"
      cook_args << "--tmp-root #{File.expand_path(get_working_path)}"
      cook_args << "--no-deps"

      cook_args
    end

    def execute(cook_args)
      env_vars = EnvVars.from_cook(options)

      command = "#{env_vars.join " "} #{FPM_COOKERY_COMMAND} #{cook_args.join " "}"

      debug(command) if options.debug
      trace(command) if options.trace

      Process.run(command)
    end

    def debug(command)
      STDOUT.puts ''
      STDOUT.puts command
      STDOUT.puts ''
    end

    def trace(command)
      STDOUT.puts '*' * 80
      STDOUT.puts ''
      STDOUT.puts 'Gordon will run the following command:'

      debug(command)

      STDOUT.puts 'With these environment variables:'
      STDOUT.puts ''
      STDOUT.puts ENV.sort.map { |k, v| "#{k} = #{v}" }.join "\n"
      STDOUT.puts ''
      STDOUT.puts '*' * 80
    end
  end
end

