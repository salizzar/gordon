require 'forwardable'

module Gordon
  class Recipe
    attr_reader :options, :skeleton

    def initialize(options)
      @options = options
      @skeleton = Skeleton::Info.new(options.skeleton_type, options.source_dir)
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
      application = Application::Factory.create(options.app_type)

      application.template_path
    end
  end
end

