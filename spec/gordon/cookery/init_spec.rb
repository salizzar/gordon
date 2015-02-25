require 'spec_helper'

describe Gordon::Cookery::Init do
  subject do
    class MyInit
      include Gordon::Cookery::Init
    end.new
  end

  let(:app_name)    { "gordon" }
  let(:init_type)   { :systemd }
  let(:build_path)  { '/tmp/gordon/tmp-build/systemd' }
  let(:skeleton)    { Gordon::Skeleton::Types::Systemd.new }
  let(:env_vars)    { instance_double Gordon::EnvVars, app_name: app_name, init_type: init_type }

  before :each do
    expect(subject).to receive(:builddir).with(env_vars.init_type).and_return(build_path)

    expect(Gordon::Skeleton::Types::Systemd).to receive(:new).and_return(skeleton)
  end

  describe 'creating init files' do
    it 'creates init calling foreman' do
      command = %W{
        foreman
        export
        --procfile
        Procfile
        --root
        #{skeleton.path}
        --app
        #{env_vars.app_name}
        --user
        #{env_vars.app_name}
        #{env_vars.init_type}
        #{build_path}
      }

      expect(subject).to receive(:safesystem).with(command.join " ")

      subject.create_init(env_vars, init_type)
    end
  end

  describe 'installing init files' do
    it 'installs all generated files' do
      files = %w(app.target app.service app-web-1.service).map do |file|
        File.join(build_path, file)
      end

      expect(Dir).to receive(:[]).with("#{build_path}/*").and_return(files)

      installer = double 'a path helper'
      expect(subject).to receive(:root).with(skeleton.path).and_return(installer)
      expect(installer).to receive(:install).with(files)

      subject.install_init(env_vars)
    end
  end
end

