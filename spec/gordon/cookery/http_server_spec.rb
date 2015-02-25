require 'spec_helper'

describe Gordon::Cookery::HttpServer do
  subject do
    class MyHttpServer
      include Gordon::Cookery::HttpServer
    end.new
  end

  let(:app_name)          { "gordon" }
  let(:http_server_type)  { :apache }
  let(:env_vars)          { double Gordon::EnvVars, app_name: app_name, http_server_type: http_server_type }
  let(:skeleton)          { Gordon::Skeleton::Types::Apache.new }
  let(:all_files)         { %w(index.php pimp_my_system.php) }
  let(:blacklist)         { %w(.git) }

  before :each do
    expect(Gordon::Skeleton::Types::Apache).to receive(:new).and_return(skeleton)
  end

  describe 'installing files' do
    it 'install files based on http server path' do
      expect(subject).to receive(:all_files_except_blacklisted).with(blacklist).and_return(all_files)

      installer = double 'a path helper'
      expect(subject).to receive(:root).with(skeleton.path).and_return(installer)
      expect(installer).to receive(:install).with(all_files)

      subject.install_http_server_files(env_vars, blacklist)
    end
  end
end

