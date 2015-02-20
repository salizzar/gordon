module Gordon
  module Cookery
    module Java
      module WebApp
        def clean_java_web_workdir(env_vars, workdir_path)
          File.open(builddir('.gordon-before-install'), 'w', 0755) do |f|
            bash = <<-__BASH
#!/bin/sh

set -e

/usr/bin/rm -rf #{workdir_path}
            __BASH

            f.write(bash)

            self.class.pre_install(File.expand_path(f.path))
          end
        end
      end
    end
  end
end

