module Gordon
  module Cookery
    module Ruby
      module Common
        RUBY_BLACKLIST_FILES = %w(coverage log spec tmp vendor/cache)

        def ruby_vendor_gems
          command = 'ruby -S bundle package --all'
          safesystem(command)

          command = 'ruby -S bundle install --deployment --without development test'
          safesystem(command)
        end
      end
    end
  end
end

