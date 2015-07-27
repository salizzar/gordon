require 'yaml'
require 'erb'

module Gordon
  class Cookbook
    def self.exists?
      File.exists?(self.get_path)
    end

    def self.read_and_merge_with(main_options)
      path = self.get_path
      body = File.read(path)
      yaml = ERB.new(body)
      data = YAML.load(yaml.result)

      data['recipes'].map do |recipe|
        option = Options.from(main_options, recipe)
        Recipe.new(option)
      end
    end

    private

    def self.get_path
      File.join(Dir.pwd, 'gordon.yml')
    end
  end
end

