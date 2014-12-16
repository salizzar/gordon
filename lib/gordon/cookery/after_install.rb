module Gordon
  module Cookery
    module AfterInstall
      def create_after_install(home_path)
        File.open(builddir('after-install'), 'w', 0755) do |f|
          bash = <<-__BASH
#!/bin/sh

set -e

/usr/bin/chown -R #{$env_vars.app_name}:#{$env_vars.app_name} #{home_path}

              __BASH

          f.write(bash)

          self.class.post_install(File.expand_path(f.path))
        end
      end
    end
  end
end

