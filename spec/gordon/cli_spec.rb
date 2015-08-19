require 'spec_helper'

describe Gordon::CLI do
  describe 'running a recipe' do
    let(:options)   { instance_double Gordon::Options }
    let(:recipe)    { instance_double Gordon::Recipe }
    let(:cooker)    { instance_double Gordon::Cooker }
    let(:recipes)   { [ recipe ] }

    before :each do
      expect(options).to receive(:app_source=).with(Dir.pwd)
      expect(options).to receive(:output_dir=).with(Dir.pwd)

      expect(Gordon::Options).to receive(:new).and_return(options)
    end

    it 'cooks a single recipe based on options' do
      expect(Gordon::Cookbook).to receive(:exists?).and_return(false)
      expect(Gordon::Cookbook).to_not receive(:read_and_merge_with)

      expect(Gordon::Recipe).to receive(:new).with(options).and_return(recipe)
      expect(Gordon::Cooker).to receive(:new).with(recipes).and_return(cooker)

      expect(cooker).to receive(:cook)

      described_class.run
    end

    it 'cooks a list of recipes based on cookbook file' do
      expect(Gordon::Cookbook).to receive(:exists?).and_return(true)
      expect(Gordon::Cookbook).to receive(:read_and_merge_with).with(options).and_return(recipes)

      expect(Gordon::Recipe).to_not receive(:new)
      expect(Gordon::Cooker).to receive(:new).with(recipes).and_return(cooker)

      expect(cooker).to receive(:cook)

      described_class.run
    end
  end

  describe 'parsing options' do
    let(:options) { instance_double Gordon::Options }

    let(:options_map) do
      [
        [ %w(-N --app-name),            "gordon" ],
        [ %w(-D --app-description),     "a packager" ],
        [ %w(-G --app-homepage),        "https://github.com/salizzar/gordon" ],
        [ %w(-V --app-version),         Gordon::VERSION ],
        [ %w(-S --app-source),          "." ],
        [ %w(-E --app-source-excludes), %(an path) ],
        [ %w(-T --app-type),            "web" ],
        [ %w(-C --recipe),              "xirubiru.yml" ],
        [ %w(-X --runtime-name),        "ruby" ],
        [ %w(-R --runtime-version),     "2.2.0" ],
        [ %w(-H --http-server-type),    "nginx" ],
        [ %w(-W --web-server-type),     "unicorn" ],
        [ %w(-I --init-type),           "systemd" ],
        [ %w(-P --package-type),        "rpm" ],
        [ %w(-O --output-dir),          "pkg" ],
        [ %w(-d --debug),               true ],
        [ %w(-t --trace),               true ],
      ]
    end

    let(:abbreviated) do
      options_map.map { |item| [ item.first.first, item.last ] }
    end

    let(:detailed) do
      options_map.map { |item| [ item.first.last, item.last ] }
    end

    before :each do
      options_map.each do |item|
        attr = item.first.last.gsub(/^--/, '').tr('-', '_')

        expect(options).to receive("#{attr}=").with(item.last)
      end
    end

    it 'maps abbreviated options' do
      parser = described_class.create_option_parser(options)
      parser.parse!(abbreviated.flatten)
    end

    it 'maps detailed options' do
      parser = described_class.create_option_parser(options)
      parser.parse!(detailed.flatten)
    end
  end
end

