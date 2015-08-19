require 'yaml'
require 'erb'

module Gordon
  class Cookbook
    def self.exists?(options)
      path = self.get_path(options)
      !path.nil?
    end

    def self.read_and_merge_with(main_options)
      path = self.get_path(main_options)
      raise Exceptions::RecipeNotFound.new if path.nil?

      body = File.read(path)
      yaml = ERB.new(body)
      data = YAML.load(yaml.result)

      data['recipes'].map do |recipe|
        option = Options.from(main_options, recipe)
        Recipe.new(option)
      end
    end

    private

    def self.get_path(options)
      recipe = options.recipe.to_s

      unless recipe.empty?
        recipe_yaml_path = self.get_recipe_yaml_path(recipe)
        return recipe_yaml_path if File.exists?(recipe_yaml_path)
      end

      gordon_yaml_path = self.get_gordon_yaml_path
      return gordon_yaml_path if File.exists?(gordon_yaml_path)

      nil
    end

    def self.get_gordon_yaml_path
      self.get_recipe_path('gordon.yml')
    end

    def self.get_recipe_yaml_path(recipe)
      self.get_recipe_path(recipe)
    end

    def self.get_recipe_path(recipe)
      File.join(Dir.pwd, recipe)
    end
  end
end

