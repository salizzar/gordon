require 'spec_helper'

describe Gordon::Cookbook do
  let(:path) { File.join(Dir.pwd, 'gordon.yml') }

  context 'checking if file exists' do
    it 'returns true when exists' do
      expect(File).to receive(:exists?).with(path).and_return(true)

      expect(described_class.exists?).to be_truthy
    end

    it 'returns false otherwise' do
      expect(File).to receive(:exists?).with(path).and_return(false)

      expect(described_class.exists?).to be_falsey
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

    it 'renders gordon yaml file and returns a list of recipes' do
      expect(File).to receive(:read).with(path).and_return(content)

      erb = instance_double(ERB)
      expect(erb).to receive(:result).and_return(result)
      expect(ERB).to receive(:new).with(content).and_return(erb)
      expect(YAML).to receive(:load).with(result).and_return(yaml)

      option = instance_double(Gordon::Options)
      expect(Gordon::Options).to receive(:from).with(main_options, yaml['recipes'].first).and_return(option)
      expect(Gordon::Recipe).to receive(:new).with(option).and_return(recipe)

      expect(described_class.read_and_merge_with(main_options)).to eq(recipes)
    end
  end
end

