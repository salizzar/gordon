module Gordon
  module Application
    module Types
      module Base
        def get_template_path
          curdir = File.dirname(__FILE__)
          template_path = File.join(curdir, 'templates', "#{get_template}.rb")

          File.expand_path(template_path)
        end
      end

      class RubyWebApp
        include Base

        def get_template ; 'ruby_web_app' ; end
      end

      class RubyStandaloneApp
        include Base

        def get_template ; 'ruby_standalone_app' ; end
      end

      class JavaWebApp
        include Base

        def get_template ; 'java_web_app' ; end
      end

      class JavaStandaloneApp
        include Base

        def get_template ; 'java_standalone_app' ; end
      end
    end
  end
end

