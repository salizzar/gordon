module Gordon
  module Cookery
    module Common
      MAIN_BLACKLIST_FILES = %w(Vagrantfile)

      def get_skeleton_path_from_type(type)
        skeleton_type = Skeleton::Factory.create(type)
        skeleton_type.path(skeleton_type.requires_app_name? ? $env_vars.app_name : '')
      end

      def all_files_except_blacklisted(*custom_blacklist_files)
        blacklist = (MAIN_BLACKLIST_FILES + custom_blacklist_files).flatten

        # TODO: create a way to make a performatic grep here to avoid undesired/directory/*
        files = Dir['*'] - blacklist

        files
      end
    end
  end
end

