module Gordon
  module Cookery
    module HttpServer
      def install_http_server_files(env_vars, blacklist)
        skeleton_path = get_skeleton_path_from_type(env_vars.http_server_type)

        application_files = all_files_except_blacklisted(blacklist)

        root(skeleton_path).install application_files
      end
    end
  end
end

