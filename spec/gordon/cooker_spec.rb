require 'spec_helper'

describe Gordon::Cooker do
  let(:options) do
    attrs = {
      app_type:         "web",
      app_name:         "gordon",
      app_description:  "a packager",
      app_homepage:     "https://github.com/salizzar/gordon",
      app_version:      Gordon::VERSION,
      app_source:       ".",
      runtime_name:     "ruby",
      runtime_version:  "2.2.0",
      http_server_type: "nginx",
      web_server_type:  "unicorn",
      init_type:        "systemd",
      package_type:     "rpm",
      output_dir:       "pkg",
      debug:            true,
    }

    instance_double(Gordon::Options, attrs)
  end

  let(:recipe) do
    instance_double(Gordon::Recipe, options: options, application_template_path: '/a/path')
  end

  let(:env_vars) do
    Gordon::EnvVars.from_cook(options)
  end

  subject { described_class.new(recipe) }

  before :each do
    expect(subject).to receive(:debug)
  end

  describe 'cooking a package' do
    it 'cleans fpm-cookery working directory' do
      clean_command = %W{
        #{env_vars.join " "}
        fpm-cook
        --debug
        --target
        #{options.package_type}
        --pkg-dir
        #{File.expand_path(options.output_dir)}
        --cache-dir
        #{File.expand_path(described_class::FPM_COOKERY_CACHE_DIR)}
        --tmp-root
        #{File.expand_path(described_class::FPM_COOKERY_BUILD_DIR)}
        --no-deps
        clean
        #{recipe.application_template_path}
      }

      expect(Gordon::Process).to receive(:run).with(clean_command.join " ")

      expect(subject).to receive(:package)

      subject.cook
    end

    it 'packages calling fpm-cookery' do
      package_command = %W{
        #{env_vars.join " "}
        fpm-cook
        --debug
        --target
        #{options.package_type}
        --pkg-dir
        #{File.expand_path(options.output_dir)}
        --cache-dir
        #{File.expand_path(described_class::FPM_COOKERY_CACHE_DIR)}
        --tmp-root
        #{File.expand_path(described_class::FPM_COOKERY_BUILD_DIR)}
        --no-deps
        package
        #{recipe.application_template_path}
      }

      expect(Gordon::Process).to receive(:run).with(package_command.join " ")

      expect(subject).to receive(:clean)

      subject.cook
    end
  end
end

