module Gordon
  module Cookery
    module DependencyResolver
      include Common

      def resolve_dependencies(env_vars, platform)
        dependencies = []

        dependencies << get_runtime_package_name(env_vars, platform)
        dependencies << get_http_server_package_name(env_vars, platform)  unless env_vars.http_server_type.to_s.empty?
        dependencies << get_init_package_name(env_vars, platform)         unless env_vars.init_type.to_s.empty?
        dependencies << get_web_server_package_name(env_vars, platform)   unless env_vars.web_server_type.to_s.empty?

        dependencies.collect(&:to_s)
      end

      private

      def get_runtime_package_name(env_vars, platform)
        runtime_name, runtime_version = env_vars.runtime_name, env_vars.runtime_version

        if runtime_name =~ /j(dk|re)/
          package_name = get_java_package_name(runtime_name, runtime_version, platform)
        else
          package_name = "#{runtime_name} = #{runtime_version}"
        end

        package_name
      end

      def get_java_package_name(runtime_name, runtime_version, platform)
        centos = platform == :centos

        if runtime_name =~ /oracle/ && centos
          package_name = get_oracle_package_name(runtime_name, runtime_version)
        else
          package_name = get_osjava_package_name(runtime_name, runtime_version, centos)
        end

        package_name
      end

      def oracle_8_version?(runtime_version)
        runtime_version[2].to_s == '8'
      end

      def get_oracle_package_name(runtime_name, runtime_version)
        package_type = runtime_name =~ /jre/ ? :jre : :jdk

        if oracle_8_version?(runtime_version)
          package_name = "#{package_type}#{runtime_version}"
        else
          package_name = "#{package_type} = #{runtime_version}"
        end

        package_name
      end

      def get_osjava_package_name(runtime_name, runtime_version, is_centos)
        if is_centos
          package_name = "java-#{runtime_version[0..4]}-openjdk"
        else
          package_name = "openjdk-#{runtime_version[2]}-jre"
        end

        package_name
      end

      def get_http_server_package_name(env_vars, platform)
        get_os_package_name(env_vars, :http_server_type, platform)
      end

      def get_init_package_name(env_vars, platform)
        get_os_package_name(env_vars, :init_type, platform)
      end

      def get_web_server_package_name(env_vars, platform)
        get_os_package_name(env_vars, :web_server_type, platform)
      end

      def get_os_package_name(env_vars, attribute, platform)
        skeleton_type = create_skeleton_type(env_vars.send(attribute))
        os_package_name = skeleton_type.get_os_package_name(platform)

        os_package_name
      end
    end
  end
end

