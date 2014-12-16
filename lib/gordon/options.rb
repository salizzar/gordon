module Gordon
  class Options
    attr_accessor :app_type, :app_name, :app_desc, :app_repo, :app_version
    attr_accessor :package_type
    attr_accessor :source_dir
    attr_accessor :output_dir
    attr_accessor :http_server_type
    attr_accessor :init_type
    attr_accessor :debug

    def debug? ; !!debug ; end
  end
end
