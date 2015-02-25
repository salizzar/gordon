module Gordon
  module Exceptions
    class OperationalSystemNotMapped < RuntimeError
      def initialize(class_name, os_name)
        super("Operational System not mapped for #{class_name}. OS: #{os_name}")
      end
    end
  end
end

