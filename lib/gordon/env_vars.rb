module Gordon
  class EnvVars
    attr_accessor :app_type
    attr_accessor :app_name, :app_description, :app_homepage, :app_version, :app_source
    attr_accessor :runtime_name, :runtime_version
    attr_accessor :http_server_type
    attr_accessor :web_server_type
    attr_accessor :init_type

    def self.from_cook(options)
      env_vars = []

      env_vars << "GORDON_APP_TYPE='#{options.app_type}'"
      env_vars << "GORDON_APP_NAME='#{options.app_name}'"
      env_vars << "GORDON_APP_DESCRIPTION='#{options.app_description}'"
      env_vars << "GORDON_APP_HOMEPAGE='#{options.app_homepage}'"
      env_vars << "GORDON_APP_VERSION='#{options.app_version}'"
      env_vars << "GORDON_APP_SOURCE='#{File.expand_path(options.app_source)}'"
      env_vars << "GORDON_RUNTIME_NAME='#{options.runtime_name}'"
      env_vars << "GORDON_RUNTIME_VERSION='#{options.runtime_version}'"
      env_vars << "GORDON_HTTP_SERVER_TYPE='#{options.http_server_type}'"
      env_vars << "GORDON_WEB_SERVER_TYPE='#{options.web_server_type}'"
      env_vars << "GORDON_INIT_TYPE='#{options.init_type}'"

      env_vars
    end

    def self.load
      env_vars = self.new

      env_vars.app_type         = ENV['GORDON_APP_TYPE']
      env_vars.app_name         = ENV['GORDON_APP_NAME']
      env_vars.app_description  = ENV['GORDON_APP_DESCRIPTION']
      env_vars.app_homepage     = ENV['GORDON_APP_HOMEPAGE']
      env_vars.app_version      = ENV['GORDON_APP_VERSION']
      env_vars.app_source       = ENV['GORDON_APP_SOURCE']
      env_vars.runtime_name     = ENV['GORDON_RUNTIME_NAME']
      env_vars.runtime_version  = ENV['GORDON_RUNTIME_VERSION']
      env_vars.http_server_type = ENV['GORDON_HTTP_SERVER_TYPE']
      env_vars.web_server_type  = ENV['GORDON_WEB_SERVER_TYPE']
      env_vars.init_type        = ENV['GORDON_INIT_TYPE']

      env_vars
    end
  end
end

