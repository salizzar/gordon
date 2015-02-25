require 'spec_helper'

describe Gordon::Cookery::Java::WebApp do
  subject do
    class MyJavaWebApp
      include Gordon::Cookery::Java::WebApp
    end.new
  end

  let(:env_vars)              { instance_double Gordon::EnvVars }
  let(:workdir_path)          { '/var/lib/tomcat/webapps/myapp' }
  let(:build_path)            { 'tmp-build' }
  let(:preinstall_file_name)  { '.gordon-before-install' }
  let(:preinstall_path)       { File.join(build_path, preinstall_file_name) }
  let(:file)                  { instance_double File }

  describe 'cleaning web app workdir before install package' do
    it 'removes old application folder' do
      expect(subject).to receive(:builddir).with(preinstall_file_name).and_return(preinstall_path)

      expect(File).to receive(:open).with(preinstall_path, 'w', 0755).and_yield(file)
      allow(file).to receive(:path).and_return(preinstall_path)

      bash = <<-__BASH
#!/bin/sh

set -e

/usr/bin/rm -rf #{workdir_path}
      __BASH

      expect(file).to receive(:write).with(bash)

      expect(subject.class).to receive(:pre_install).with(File.expand_path(file.path))

      subject.clean_java_web_workdir(env_vars, workdir_path)
    end
  end
end

