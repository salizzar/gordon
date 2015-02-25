require 'spec_helper'

describe Gordon::Cookery::WebServer do
  subject do
    class MyWebServer
      include Gordon::Cookery::WebServer
    end.new
  end

  let(:app_name)        { "gordon" }
  let(:web_server_type) { :tomcat }
  let(:env_vars)        { double Gordon::EnvVars, app_name: app_name, web_server_type: web_server_type }
  let(:skeleton)        { Gordon::Skeleton::Types::Tomcat.new }
  let(:all_files)       { %w(gordon.war) }
  let(:blacklist)       { %w(gordon.class) }

  before :each do
    expect(Gordon::Skeleton::Types::Tomcat).to receive(:new).and_return(skeleton)
  end

  describe 'installing web server files' do
    it 'install files based on web server path' do
      expect(subject).to receive(:all_files_except_blacklisted).with(blacklist).and_return(all_files)

      installer = double 'a path helper'
      expect(subject).to receive(:root).with(skeleton.path).and_return(installer)
      expect(installer).to receive(:install).with(all_files)

      subject.install_web_server_files(env_vars, blacklist)
    end
  end
end

