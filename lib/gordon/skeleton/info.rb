module Gordon
  module Skeleton
    class Info
      attr_reader :type, :artifacts

      BLACKLIST = %w(.git log spec Vagrantfile)

      def initialize(type, source_dir)
        @type, @artifacts = type, clean_source_files(source_dir)
      end

      private

      def clean_source_files(source_dir)
        source_path = File.join(source_dir, '*')

        all_files = Dir[source_path]

        blacklist = BLACKLIST.map do |file|
          File.join(source_dir, file)
        end

        all_files - blacklist
      end
    end
  end
end

