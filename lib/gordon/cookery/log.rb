module Gordon
  module Cookery
    module Log
      def create_log_folder(env_vars)
        log_path = "/var/log/#{env_vars.app_name}"

        root(log_path).mkdir
      end
    end
  end
end

