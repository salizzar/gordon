module Gordon
  module Skeleton
    module Types
      module Base
        def path(app = '')
          File.join(get_default_path, app)
        end

        def requires_app_name?
          false
        end
      end

      class Nginx
        include Base

        def get_default_path ; '/usr/share/nginx/html' ; end
      end

      class Httpd
        include Base

        def get_default_path ; '/var/www/html' ; end
      end

      class Misc
        include Base

        def get_default_path ; '/opt' ; end

        def requires_app_name?
          true
        end
      end

      class Systemd
        include Base

        def get_default_path ; '/usr/lib/systemd/system' ; end

        def requires_app_name?
          true
        end
      end

      class Factory
        def self.create(skeleton_type)
          namespace = "Skeleton::Types"

          ::Gordon::Factory.create_instance(namespace, skeleton_type)
        end
      end
    end
  end
end

