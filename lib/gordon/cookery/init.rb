module Gordon
  module Cookery
    module Init
      def setup_init_files
        create_init_files
        install_init_files
      end

      def create_init_files
        init_build_dir_path = File.join($init_build_dir, $init_type)

        command = "ruby -S foreman export --app #{$app_name} #{$init_type} #{init_build_dir_path}"
        ::Gordon::Process.run(command)
      end

      def install_init_files
        init_build_dir_path = File.join($init_build_dir, $init_type)

        skeleton_type = ::Gordon::Skeleton::Types::Factory.create($init_type)
        path = get_skeleton_path(skeleton_type)

        root(path).install Dir["#{init_build_dir_path}/*"]
      end
    end
  end
end

