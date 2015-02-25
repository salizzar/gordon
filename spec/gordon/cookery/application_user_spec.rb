require 'spec_helper'

describe Gordon::Cookery::ApplicationUser do
  subject do
    class MyApplicationUser
      include Gordon::Cookery::ApplicationUser
    end.new
  end

  let(:app_name)              { "gordon" }
  let(:app_description)       { "a packager" }
  let(:build_path)            { 'tmp-build' }
  let(:preinstall_file_name)  { '.gordon-before-install' }
  let(:postinstall_file_name) { '.gordon-after-install' }
  let(:preinstall_path)       { File.join(build_path, preinstall_file_name) }
  let(:postinstall_path)      { File.join(build_path, preinstall_file_name) }
  let(:file)                  { instance_double File }
  let(:env_vars)              { instance_double Gordon::EnvVars, app_name: app_name, app_description: app_description }
  let(:home_path)             { '/usr/share/nginx/html' }

  describe 'creating user and group' do
    it 'installs script to create user on system' do
      expect(subject).to receive(:builddir).with(preinstall_file_name).and_return(preinstall_path)

      expect(File).to receive(:open).with(preinstall_path, 'w', 0755).and_yield(file)
      allow(file).to receive(:path).and_return(preinstall_path)

      bash = <<-__BASH
#!/bin/sh

set -e

/usr/bin/getent group  #{env_vars.app_name} >/dev/null || /usr/sbin/groupadd --system #{env_vars.app_name};
/usr/bin/getent passwd #{env_vars.app_name} >/dev/null || /usr/sbin/useradd  --system --gid #{env_vars.app_name} --home-dir #{home_path} --shell /sbin/nologin --comment "#{env_vars.app_description}" #{env_vars.app_name} >/dev/null || :;
      __BASH

      expect(file).to receive(:write).with(bash)

      expect(subject.class).to receive(:pre_install).with(File.expand_path(file.path))

      subject.create_user_and_group(env_vars, home_path)
    end
  end

  describe 'setting user permissions' do
    it 'install script to recursively own all files from home path' do
      expect(subject).to receive(:builddir).with(postinstall_file_name).and_return(postinstall_path)

      expect(File).to receive(:open).with(postinstall_path, 'w', 0755).and_yield(file)
      allow(file).to receive(:path).and_return(postinstall_path)

      bash = <<-__BASH
#!/bin/sh

set -e

/usr/bin/chown -R #{env_vars.app_name}:#{env_vars.app_name} #{home_path}
      __BASH

      expect(file).to receive(:write).with(bash)

      expect(subject.class).to receive(:post_install).with(File.expand_path(file.path))

      subject.setup_user_permissions(env_vars, home_path)
    end
  end
end

