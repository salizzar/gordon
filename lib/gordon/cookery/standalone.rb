module Gordon
  module Cookery
    module Standalone
      def install_standalone_files(env_vars, blacklist)
        skeleton_path = get_skeleton_path_from_type(:misc)

        application_files = all_files_except_blacklisted(blacklist)

        root(skeleton_path).install application_files
      end
    end
  end
end


