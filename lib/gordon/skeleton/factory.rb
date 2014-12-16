module Gordon
  module Skeleton
    class Factory
      def self.create(skeleton_type)
        namespace = "Skeleton::Types"

        ::Gordon::Factory.create_instance(namespace, skeleton_type)
      end
    end
  end
end

