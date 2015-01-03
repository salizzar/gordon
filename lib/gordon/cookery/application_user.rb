module Gordon
  module Cookery
    module ApplicationUser
      def create_user_and_group(env_vars, home_path)
        File.open(builddir('.gordon-before-install'), 'w', 0755) do |f|
          bash = <<-__BASH
#!/bin/sh

set -e

/usr/bin/getent group  #{env_vars.app_name} >/dev/null || /usr/sbin/groupadd --system #{env_vars.app_name};
/usr/bin/getent passwd #{env_vars.app_name} >/dev/null || /usr/sbin/useradd  --system --gid #{env_vars.app_name} --home-dir #{home_path} --shell /sbin/nologin --comment "#{env_vars.app_desc}" #{env_vars.app_name} >/dev/null || :;

              __BASH

          f.write(bash)

          self.class.pre_install(File.expand_path(f.path))
        end
      end

      def setup_user_permissions(env_vars, home_path)
        File.open(builddir('.gordon-after-install'), 'w', 0755) do |f|
          bash = <<-__BASH
#!/bin/sh

set -e

/usr/bin/chown -R #{env_vars.app_name}:#{env_vars.app_name} #{home_path}

              __BASH

          f.write(bash)

          self.class.post_install(File.expand_path(f.path))
        end
      end
    end
  end
end

