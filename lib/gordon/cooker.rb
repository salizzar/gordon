module Gordon
  class Cooker
    attr_reader :options, :recipe

    def initialize(recipe, options)
      @recipe = recipe
      @options = options
    end

    def cook
      cook_args = []

      cook_args << "--debug"    if options.debug?

      cook_args << "--target #{options.package_type}"
      cook_args << "--cache-dir #{options.build_dir}"
      cook_args << "--platform #{recipe.platform}" if recipe.requires_platform?
      cook_args << "--tmp-root #{options.build_dir}"
      cook_args << "--pkg-dir #{options.package_dir}"
      cook_args << "package"
      cook_args << recipe.application_template_path

      env_vars = get_env_vars
      command = "#{env_vars.join " "} ruby -S fpm-cook #{cook_args.join " "}"

      if options.debug?
        puts ''
        puts command
        puts ''
      end

      Process.run(command)
    end

    private

    def get_env_vars
      env_vars = []

      env_vars << "GORDON_APP_NAME=#{options.app_name}"
      env_vars << "GORDON_APP_DESC=#{options.app_desc}"
      env_vars << "GORDON_APP_REPO=#{options.app_repo}"
      env_vars << "GORDON_APP_VERSION=#{options.app_version}"
      env_vars << "GORDON_APP_SOURCE_DIR=#{options.source_dir}"

      env_vars << "GORDON_SKELETON_TYPE=#{recipe.skeleton.type}"
      env_vars << "GORDON_SKELETON_FILES=#{recipe.skeleton.artifacts.join(',')}"

      env_vars << "GORDON_INIT_TYPE=#{options.init_type}"
      env_vars << "GORDON_INIT_BUILD_DIR=#{options.init_build_dir}"

      env_vars
    end
  end
end

