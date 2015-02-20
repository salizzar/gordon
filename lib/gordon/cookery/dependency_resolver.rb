module Gordon
  module Cookery
    module DependencyResolver
      def resolve_dependencies(env_vars)
        fragments = env_vars.app_type.split('_')
        app_runtime, app_type = fragments[0], fragments[1]

        dependencies = []
        dependencies << get_runtime_package_name(app_runtime, env_vars)
        dependencies << get_http_server_package_name(env_vars)  unless env_vars.http_server_type.empty?
        dependencies << get_init_package_name(env_vars)         unless env_vars.init_type.empty?
        dependencies << get_web_server_package_name(env_vars)   unless env_vars.web_server_type.empty?

        dependencies.collect(&:to_s)
      end

      private

      def get_runtime_package_name(app_runtime, env_vars)
        if app_runtime == 'java'
          # TODO: get a way to handle openjdk
          runtime_name = :jre

          runtime_version = "#{runtime_name}#{env_vars.runtime_version}"
        else
          runtime_version = "#{runtime_name} = #{env_vars.runtime_version}"
        end

        runtime_version
      end

      def get_http_server_package_name(env_vars)
        get_os_package_name(env_vars, :http_server_type)
      end

      def get_init_package_name(env_vars)
        get_os_package_name(env_vars, :init_type)
      end

      def get_web_server_package_name(env_vars)
        get_os_package_name(env_vars, :web_server_type)
      end

      def get_os_package_name(env_vars, attribute)
        package_type = FPM::Cookery::Facts.platform.to_sym

        skeleton_type = create_skeleton_type(env_vars.send(attribute))
        os_package_name = skeleton_type.get_os_package_map[package_type]

        os_package_name
      end
    end
  end
end

