module Gordon
  module Cookery
    module Webserver
      def setup_webserver_files
        skeleton_type = ::Gordon::Skeleton::Types::Factory.create($skeleton_type)
        skeleton_path = get_skeleton_path(skeleton_type)

        root(skeleton_path).install common_ruby_files
        root(skeleton_path).install $skeleton_files.split(',')
      end
    end
  end
end

