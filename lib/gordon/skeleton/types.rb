module Gordon
  module Skeleton
    module Types
      module Base
        def path(app = '')
          File.join(get_default_path, app.to_s)
        end

        def requires_app_name?
          false
        end
      end

      class Nginx
        include Base

        def get_os_package_map ; { centos: :nginx, debian: :nginx } ; end

        def get_default_path ; '/usr/share/nginx/html' ; end
      end

      class Apache
        include Base

        def get_os_package_map ; { centos: :httpd, debian: :apache2 } ; end

        def get_default_path ; '/var/www/html' ; end
      end

      class Systemd
        include Base

        def get_os_package_map ; { centos: :systemd, debian: :systemd } ; end

        def get_default_path ; '/usr/lib/systemd/system' ; end
      end

      class Misc
        include Base

        def get_default_path ; '/opt' ; end

        def requires_app_name?
          true
        end
      end
    end
  end
end

