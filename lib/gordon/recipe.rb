module Gordon
  class Recipe
    attr_reader :options, :application

    def initialize(options)
      @options = options
      @application = Application::Factory.create(options)
    end

    def application_template_path
      application.get_template_path
    end
  end
end

