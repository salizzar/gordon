module Gordon
  class Options
    attr_accessor :app_type, :app_name, :app_desc, :app_repo, :app_version
    attr_accessor :package_type, :package_dir
    attr_accessor :source_dir, :build_dir
    attr_accessor :skeleton_type
    attr_accessor :init_type, :init_build_dir
    attr_accessor :debug

    def debug? ; !!debug ; end
  end
end
