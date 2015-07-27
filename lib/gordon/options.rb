module Gordon
  class Options
    attr_accessor :app_name, :app_description, :app_homepage, :app_version, :app_source, :app_source_excludes, :app_type
    attr_accessor :runtime_name, :runtime_version
    attr_accessor :http_server_type
    attr_accessor :web_server_type
    attr_accessor :init_type
    attr_accessor :package_type
    attr_accessor :output_dir
    attr_accessor :debug, :trace

    def self.from(main_options, recipe)
      self.new.tap do |opt|
        opt.app_type            = main_options.app_type         || recipe['app_type']
        opt.app_name            = main_options.app_name         || recipe['app_name']
        opt.app_description     = main_options.app_description  || recipe['app_description']
        opt.app_homepage        = main_options.app_homepage     || recipe['app_homepage']
        opt.app_version         = main_options.app_version      || recipe['app_version']
        opt.app_source          = recipe['app_source']          || main_options.app_source

        opt.app_source_excludes = (main_options.app_source_excludes.to_a + recipe['app_source_excludes'].to_a).flatten

        opt.runtime_name        = main_options.runtime_name         || recipe['runtime_name']
        opt.runtime_version     = main_options.runtime_version      || recipe['runtime_version']

        opt.http_server_type    = main_options.http_server_type     || recipe['http_server_type']
        opt.web_server_type     = main_options.web_server_type      || recipe['web_server_type']
        opt.init_type           = main_options.init_type            || recipe['init_type']

        opt.package_type        = main_options.package_type         || recipe['package_type']
        opt.output_dir          = main_options.output_dir           || recipe['output_dir']

        opt.debug               = !main_options.debug.nil? ? main_options.debug : recipe['debug']
        opt.trace               = !main_options.trace.nil? ? main_options.trace : recipe['trace']
      end
    end
  end
end

