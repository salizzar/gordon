module Gordon
  module Application
    class Factory
      def self.create(options)
        namespace = "Application::Types"

        runtime_name = options.runtime_name
        runtime_name = :java if runtime_name =~ /j(dk|re)/
        application_type = "#{runtime_name}_#{options.app_type}_app"

        ::Gordon::Factory.create_instance(namespace, application_type)
      end
    end
  end
end

