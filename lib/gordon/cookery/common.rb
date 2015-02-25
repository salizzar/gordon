module Gordon
  module Cookery
    module Common
      MAIN_BLACKLIST_FILES = %w(.git .gitignore .pki Vagrantfile cruise-output)

      def self.included(base)
        base.send(:extend, self)
      end

      def get_skeleton_path_from_type(env_vars, type)
        skeleton_type = create_skeleton_type(type)
        appended_path = skeleton_type.requires_app_name? ? env_vars.app_name : ''
        skeleton_type.path(appended_path)
      end

      def create_skeleton_type(type)
        Skeleton::Factory.create(type)
      end

      def all_files_except_blacklisted(*custom_blacklist_files)
        blacklist = (MAIN_BLACKLIST_FILES + custom_blacklist_files).flatten

        # TODO: create a way to make a performatic grep here to avoid undesired/directory/*
        files = Dir['{*,.*}'].sort[2..-1].reject do |entry|
          pattern = entry.gsub(/\./, '\.').gsub(/\//, '\/')

          found = blacklist.grep(/#{pattern}/i)

          found.any?
        end

        files
      end
    end
  end
end

