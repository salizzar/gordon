require 'spec_helper'

describe Gordon::Cookery::Standalone do
  subject do
    class MyStandalone
      include Gordon::Cookery::Standalone
    end.new
  end

  let(:app_name)  { "gordon" }
  let(:env_vars)  { instance_double Gordon::EnvVars, app_name: app_name }
  let(:skeleton)  { Gordon::Skeleton::Types::Misc.new }
  let(:all_files) { %w(.bundle app config lib .ruby-version .ruby-gemset) }
  let(:blacklist) { %w(.git) }

  before :each do
    expect(Gordon::Skeleton::Types::Misc).to receive(:new).and_return(skeleton)
  end

  describe 'installing files' do
    it 'install all files based on misc skeleton' do
      expect(subject).to receive(:all_files_except_blacklisted).with(blacklist).and_return(all_files)

      installer = double 'a path helper'
      expect(subject).to receive(:root).with(skeleton.path(app_name)).and_return(installer)
      expect(installer).to receive(:install).with(all_files)

      subject.install_standalone_files(env_vars, blacklist)
    end
  end
end

