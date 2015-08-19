require 'spec_helper'

describe Gordon::Cookbook do
  let(:gordon_yaml_path) { File.join(Dir.pwd, 'gordon.yml') }
  let(:recipe_yaml_path) { File.join(Dir.pwd, 'recipe.yml') }

  context 'checking if file exists' do
    let(:options) { instance_double(Gordon::Options) }

    it 'returns true when recipe yaml exists' do
      expect(options).to receive(:recipe).and_return('recipe.yml')

      expect(File).to     receive(:exists?).with(recipe_yaml_path).and_return(true)
      expect(File).to_not receive(:exists?).with(gordon_yaml_path)

      expect(described_class.exists?(options)).to be_truthy
    end

    it 'returns true when gordon yaml exists' do
      expect(options).to receive(:recipe).and_return(nil)

      expect(File).to     receive(:exists?).with(gordon_yaml_path).and_return(true)
      expect(File).to_not receive(:exists?).with(recipe_yaml_path)

      expect(described_class.exists?(options)).to be_truthy
    end
  end

  context 'reading and merging with main options' do
    let(:content) do
      %{
        recipes:
          - app_name:           gordon
            app_description:    some description
            app_homepage:       https://github.com/salizzar/gordon
            app_version:        <%= 1 + 1 %>.0.0
            app_type:           web
            app_source:         .
      }
    end

    let(:result)        { ERB.new(content).result }
    let(:yaml)          { YAML.load(result) }

    let(:main_options)  { instance_double(Gordon::Options) }
    let(:recipe)        { instance_double(Gordon::Recipe) }
    let(:recipes)       { [ recipe ] }

    it 'renders recipe yaml file and returns a list of recipes' do
      expect(main_options).to receive(:recipe).and_return('recipe.yml')

      expect(File).to     receive(:exists?).with(recipe_yaml_path).and_return(true)
      expect(File).to_not receive(:exists?).with(gordon_yaml_path)

      expect(File).to receive(:read).with(recipe_yaml_path).and_return(content)

      erb = instance_double(ERB)
      expect(erb).to  receive(:result).and_return(result)
      expect(ERB).to  receive(:new).with(content).and_return(erb)
      expect(YAML).to receive(:load).with(result).and_return(yaml)

      option = instance_double(Gordon::Options)
      expect(Gordon::Options).to receive(:from).with(main_options, yaml['recipes'].first).and_return(option)
      expect(Gordon::Recipe).to receive(:new).with(option).and_return(recipe)

      expect(described_class.read_and_merge_with(main_options)).to eq(recipes)
    end

    it 'renders gordon yaml file and returns a list of recipes' do
      expect(main_options).to receive(:recipe).and_return(nil)

      expect(File).to_not receive(:exists?).with(recipe_yaml_path)
      expect(File).to     receive(:exists?).with(gordon_yaml_path).and_return(true)

      expect(File).to     receive(:read).with(gordon_yaml_path).and_return(content)

      erb = instance_double(ERB)
      expect(erb).to  receive(:result).and_return(result)
      expect(ERB).to  receive(:new).with(content).and_return(erb)
      expect(YAML).to receive(:load).with(result).and_return(yaml)

      option = instance_double(Gordon::Options)
      expect(Gordon::Options).to receive(:from).with(main_options, yaml['recipes'].first).and_return(option)
      expect(Gordon::Recipe).to receive(:new).with(option).and_return(recipe)

      expect(described_class.read_and_merge_with(main_options)).to eq(recipes)
    end

    it 'raises error when no recipe is found' do
      expect(main_options).to receive(:recipe).and_return(nil)

      expect(File).to receive(:exists?).with(gordon_yaml_path).and_return(false)

      expect{ described_class.read_and_merge_with(main_options) }.to raise_error(Gordon::Exceptions::RecipeNotFound)
    end
  end
end

