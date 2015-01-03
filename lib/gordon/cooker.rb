module Gordon
  class Cooker
    attr_reader :recipe, :options

    FPM_COOKERY_COMMAND   = 'ruby -S fpm-cook'
    FPM_COOKERY_CACHE_DIR = '/tmp/gordon/cache'
    FPM_COOKERY_BUILD_DIR = '/tmp/gordon/build'

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
      cook_args = get_command_args

      cook_args << "clean"
      cook_args << recipe.application_template_path

      execute(cook_args)
    end

    def package
      cook_args = get_command_args

      cook_args << "package"
      cook_args << recipe.application_template_path

      execute(cook_args)
    end

    def get_command_args
      cook_args = []

      cook_args << "--debug"    if options.debug?

      cook_args << "--target #{options.package_type}"
      cook_args << "--platform #{recipe.platform}" if recipe.requires_platform?
      cook_args << "--pkg-dir #{File.expand_path(options.output_dir)}"
      cook_args << "--cache-dir #{File.expand_path(FPM_COOKERY_CACHE_DIR)}"
      cook_args << "--tmp-root #{File.expand_path(FPM_COOKERY_BUILD_DIR)}"
      cook_args << "--no-deps"

      cook_args
    end

    def execute(cook_args)
      env_vars = EnvVars.from_cook(options)

      command = "#{env_vars.join " "} #{FPM_COOKERY_COMMAND} #{cook_args.join " "}"

      debug(command) if options.debug?

      Process.run(command)
    end

    def debug(command)
      STDOUT.puts ''
      STDOUT.puts command
      STDOUT.puts ''
    end
  end
end

