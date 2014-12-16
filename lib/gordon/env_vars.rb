module Gordon
  class EnvVars
    attr_accessor :app_name, :app_desc, :app_repo, :app_version, :app_source_dir
    attr_accessor :http_server_type
    attr_accessor :init_type

    def self.from_cook(options)
      env_vars = []

      env_vars << "GORDON_APP_NAME='#{options.app_name}'"
      env_vars << "GORDON_APP_DESC='#{options.app_desc}'"
      env_vars << "GORDON_APP_REPO='#{options.app_repo}'"
      env_vars << "GORDON_APP_VERSION='#{options.app_version}'"
      env_vars << "GORDON_APP_SOURCE_DIR='#{File.expand_path(options.source_dir)}'"
      env_vars << "GORDON_HTTP_SERVER_TYPE='#{options.http_server_type}'"
      env_vars << "GORDON_INIT_TYPE='#{options.init_type}'"

      env_vars
    end

    def self.load
      env_vars = self.new

      env_vars.app_name         = ENV['GORDON_APP_NAME']
      env_vars.app_desc         = ENV['GORDON_APP_DESC']
      env_vars.app_repo         = ENV['GORDON_APP_REPO']
      env_vars.app_version      = ENV['GORDON_APP_VERSION']
      env_vars.app_source_dir   = ENV['GORDON_APP_SOURCE_DIR']
      env_vars.http_server_type = ENV['GORDON_HTTP_SERVER_TYPE']
      env_vars.init_type        = ENV['GORDON_INIT_TYPE']

      env_vars
    end
  end
end

