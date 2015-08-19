require 'spec_helper'

describe Gordon::Options do
  let(:main_option_attributes) do
    {
      app_name:             'a-test',
      app_description:      'a description',
      app_homepage:         'https://github.com/salizzar/gordon',
      app_version:          Gordon::VERSION,
      app_source:           '.',
      app_source_excludes:  %w(something),
      app_type:             'web',
      runtime_name:         'ruby',
      runtime_version:      '2.2.2',
      http_server_type:     'nginx',
      web_server_type:      nil,
      init_type:            'systemd',
      package_type:         'rpm',
      output_dir:           'pkg',
      debug:                false,
      trace:                true,
    }
  end

  let(:recipe) do
    {
      'app_name'            => 'xirubiru',
      'app_description'     => 'another description',
      'app_homepage'        => 'https://github.com/salizzar/xirubiru',
      'app_version'         => '1.0.1',
      'app_source'          => '/tmp',
      'app_source_excludes' =>  %w(something),
      'app_type'            => 'standalone',
      'runtime_name'        => 'ruby',
      'runtime_version'     => '2.2.1',
      'http_server_type'    => nil,
      'web_server_type'     => nil,
      'init_type'           => 'systemd',
      'package_type'        => 'rpm',
      'output_dir'          => 'pkg',
      'debug'               => true,
      'trace'               => false,
    }
  end

  let(:main_options)    { instance_double(described_class, main_option_attributes) }

  describe 'returning instance based on main options and a recipe' do
    it 'priorizes main options instead of recipe' do
      instance = described_class.from(main_options, recipe)

      main_option_attributes.delete_if do |(k, _)|
        [ :app_source, :app_source_excludes ].include?(k)
      end.each do |(k, v)|
        expect(instance.send(k)).to eq(v)
      end
    end

    it 'priorizes app source from recipe instead of main option' do
      instance = described_class.from(main_options, recipe)

      expect(instance.app_source).to eq(recipe['app_source'])
    end

    it 'priorizes output dir from recipe instead of main option' do
      instance = described_class.from(main_options, recipe)

      expect(instance.output_dir).to eq(recipe['output_dir'])
    end

    it 'merges app source excludes values from main options and recipes' do
      instance = described_class.from(main_options, recipe)

      expected = (main_option_attributes[:app_source_excludes].to_a + recipe['app_source_excludes'].to_a).flatten

      expect(instance.app_source_excludes).to eq(expected)
    end
  end
end

