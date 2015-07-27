module Gordon
  module Cookery
    module WebServer
      include Common

      def install_web_server_files(env_vars, blacklist)
        skeleton_path = get_skeleton_path_from_type(env_vars, env_vars.web_server_type)

        app_source_excludes = env_vars.app_source_excludes

        application_files = all_files_except_blacklisted(blacklist, app_source_excludes)

        root(skeleton_path).install application_files
      end
    end
  end
end
