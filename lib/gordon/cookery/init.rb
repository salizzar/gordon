module Gordon
  module Cookery
    module Init
      include Common

      def create_init(env_vars, skeleton_type)
        init_build_dir_path = builddir(env_vars.init_type)
        skeleton_path = get_skeleton_path_from_type(env_vars, skeleton_type)

        command = "foreman export --procfile Procfile --root #{skeleton_path} --app #{env_vars.app_name} --user #{env_vars.app_name} #{env_vars.init_type} #{init_build_dir_path}"

        safesystem(command)
      end

      def install_init(env_vars)
        init_build_dir_path = builddir(env_vars.init_type)

        skeleton_path = get_skeleton_path_from_type(env_vars, env_vars.init_type)
        skeleton_files = Dir["#{init_build_dir_path}/*"]

        root(skeleton_path).install skeleton_files
      end
    end
  end
end

