module Gordon
  module Cookery
    module WebServer
      def install_web_server_files(env_vars, blacklist)
        skeleton_path = get_skeleton_path_from_type(env_vars.web_server_type)

        application_files = all_files_except_blacklisted(blacklist)

        root(skeleton_path).install application_files
      end
    end
  end
end
