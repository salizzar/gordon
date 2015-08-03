module Gordon
  module Cookery
    module Standalone
      include Common

      def install_standalone_files(env_vars, blacklist)
        skeleton_path = get_skeleton_path_from_type(env_vars, :misc)

        app_source_excludes = env_vars.app_source_excludes

        application_files = all_files_except_blacklisted(blacklist, app_source_excludes)

        root(skeleton_path).install application_files
      end
    end
  end
end

