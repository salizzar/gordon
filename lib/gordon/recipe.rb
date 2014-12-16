module Gordon
  class Recipe
    attr_reader :options, :application

    def initialize(options)
      @options = options
      @application = Application::Factory.create(options.app_type)
    end

    def platform
      map = {
        'rpm' => 'centos',
        'deb' => 'debian',
      }

      map[options.package_type]
    end

    def requires_platform?
      !!platform
    end

    def application_template_path
      application.template_path
    end
  end
end

