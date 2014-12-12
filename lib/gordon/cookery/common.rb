module Gordon
  module Cookery
    module Common
      def vendor_gems
        safesystem('ruby -S bundle install --deployment --without development test')
      end

      def common_ruby_files
        %w(.bundle Gemfile Gemfile.lock Procfile config.ru vendor)
      end

      def get_skeleton_path(skeleton_type)
        skeleton_type.path(skeleton_type.requires_app_name? ? $app_name : '')
      end
    end
  end
end

