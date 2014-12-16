module Gordon
  module Application
    class Factory
      def self.create(application_type)
        namespace = "Application::Types"

        ::Gordon::Factory.create_instance(namespace, application_type)
      end
    end
  end
end

