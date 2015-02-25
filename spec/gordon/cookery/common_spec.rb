require 'spec_helper'

describe Gordon::Cookery::Common do
  subject do
    class MyCommonExample
      include Gordon::Cookery::Common
    end.new
  end

  describe 'getting skeleton path from type' do
    let(:env_vars)  { instance_double Gordon::EnvVars, app_name: 'gordon' }
    let(:skeleton)  { instance_double 'Gordon::Skeleton::Types::Anything', get_default_path: '/a/path' }
    let(:type)      { :anything }

    it 'responds from class' do
      expect(subject.class).to respond_to(:get_skeleton_path_from_type)
    end

    context 'returning based on app name' do
      before :each do
        expect(Gordon::Skeleton::Factory).to receive(:create).with(type).and_return(skeleton)
      end

      it 'returns skeleton path without app name' do
        expect(skeleton).to receive(:requires_app_name?).and_return(false)
        expect(skeleton).to receive(:path).with('').and_return('/a/path')

        result = subject.get_skeleton_path_from_type(env_vars, :anything)

        expect(result).to eq('/a/path')
      end

      it 'returns skeleton path with app name' do
        expect(skeleton).to receive(:requires_app_name?).and_return(true)
        expect(skeleton).to receive(:path).with('gordon').and_return('/a/path/gordon')

        result = subject.get_skeleton_path_from_type(env_vars, type)

        expect(result).to eq('/a/path/gordon')
      end
    end
  end

  describe 'getting all files with blacklist' do
    it 'returns all files except that are blacklisted on default map plus custom' do
      files = %w{
        .
        ..
        .bundle
        .git
        .gitignore
        .pki
        Procfile
        Vagrantfile
        app
        config
        cruise-output
        db
        lib
        log
        public
        spec
        tmp
      }

      expected = %w{
        .bundle
        Procfile
        app
        config
        db
        lib
        public
      }

      expect(Dir).to receive(:[]).with('{*,.*}').and_return(files)

      result = subject.all_files_except_blacklisted(%w(log spec tmp))
      expect(result).to eq(expected)
    end
  end
end

