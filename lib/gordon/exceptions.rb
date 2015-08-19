module Gordon
  module Exceptions
    class OperationalSystemNotMapped < RuntimeError
      def initialize(class_name, os_name)
        super("Operational System not mapped for #{class_name}. OS: #{os_name}")
      end
    end

    class RecipeNotFound < RuntimeError
      def initialize
        super("Cannot found gordon.yml or custom gordon recipe yaml.")
      end
    end
  end
end

