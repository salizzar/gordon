module Gordon
  module Cookery
    module BeforeInstall
      def create_before_install(home_path)
        File.open(builddir('before-install'), 'w', 0755) do |f|
          bash = <<-__BASH
#!/bin/sh

set -e

/usr/bin/getent group  #{$env_vars.app_name} >/dev/null || /usr/sbin/groupadd --system #{$env_vars.app_name};
/usr/bin/getent passwd #{$env_vars.app_name} >/dev/null || /usr/sbin/useradd  --system --gid #{$env_vars.app_name} --home-dir #{home_path} --shell /sbin/nologin --comment "#{$env_vars.app_desc}" #{$env_vars.app_name} >/dev/null || :;

              __BASH

          f.write(bash)

          self.class.pre_install(File.expand_path(f.path))
        end
      end
    end
  end
end

