module Gordon
  class Options
    attr_accessor :app_name, :app_description, :app_homepage, :app_version, :app_source
    attr_accessor :app_type
    attr_accessor :runtime_name, :runtime_version
    attr_accessor :http_server_type
    attr_accessor :web_server_type
    attr_accessor :init_type
    attr_accessor :package_type
    attr_accessor :output_dir
    attr_accessor :debug
  end
end
