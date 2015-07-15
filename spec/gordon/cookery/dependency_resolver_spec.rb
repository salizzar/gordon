require 'spec_helper'

describe Gordon::Cookery::DependencyResolver do
  subject do
    class MyDependencyResolver
      include Gordon::Cookery::DependencyResolver
    end.new
  end

  let(:env_vars) { instance_double Gordon::EnvVars }

  describe 'resolving dependencies' do
    context 'given a ruby app' do
      it 'returns all dependencies for web' do
        expect(env_vars).to receive(:runtime_name).and_return("ruby")
        expect(env_vars).to receive(:runtime_version).and_return("2.2.0")
        allow(env_vars).to receive(:http_server_type).and_return("apache")
        expect(env_vars).to receive(:web_server_type).and_return("")
        allow(env_vars).to receive(:init_type).and_return("systemd")

        expected = [
          "ruby = 2.2.0",
          "httpd",
          "systemd",
        ]

        expect(subject.resolve_dependencies(env_vars, :centos)).to eq(expected)
      end

      it 'returns all dependencies for standalone' do
        expect(env_vars).to receive(:runtime_name).and_return("ruby")
        expect(env_vars).to receive(:runtime_version).and_return("2.1.5")
        expect(env_vars).to receive(:http_server_type).and_return("")
        expect(env_vars).to receive(:web_server_type).and_return("")
        allow(env_vars).to receive(:init_type).and_return("systemd")

        expected = [
          "ruby = 2.1.5",
          "systemd",
        ]

        expect(subject.resolve_dependencies(env_vars, :centos)).to eq(expected)
      end
    end

    context 'given a java app' do
      it 'handles Oracle JRE 7 package' do
        allow(env_vars).to receive(:http_server_type).and_return("apache")
        expect(env_vars).to receive(:runtime_name).and_return("oracle-jre")
        allow(env_vars).to receive(:runtime_version).and_return("1.7.0_80")
        allow(env_vars).to receive(:web_server_type).and_return("tomcat")
        expect(env_vars).to receive(:init_type).and_return("")

        expected = [
          "jre = 1.7.0_80",
          "httpd",
          "tomcat",
        ]

        expect(subject.resolve_dependencies(env_vars, :centos)).to eq(expected)
      end

      it 'handles Oracle JRE 8 package' do
        allow(env_vars).to receive(:http_server_type).and_return("apache")
        expect(env_vars).to receive(:runtime_name).and_return("oracle-jre")
        allow(env_vars).to receive(:runtime_version).and_return("1.8.0_45")
        allow(env_vars).to receive(:web_server_type).and_return("tomcat")
        expect(env_vars).to receive(:init_type).and_return("")

        expected = [
          "jre1.8.0_45",
          "httpd",
          "tomcat",
        ]

        expect(subject.resolve_dependencies(env_vars, :centos)).to eq(expected)
      end

      it 'handles Oracle JDK 7 package' do
        allow(env_vars).to receive(:http_server_type).and_return("apache")
        expect(env_vars).to receive(:runtime_name).and_return("oracle-jdk")
        allow(env_vars).to receive(:runtime_version).and_return("1.7.0_80")
        allow(env_vars).to receive(:web_server_type).and_return("tomcat")
        expect(env_vars).to receive(:init_type).and_return("")

        expected = [
          "jdk = 1.7.0_80",
          "httpd",
          "tomcat",
        ]

        expect(subject.resolve_dependencies(env_vars, :centos)).to eq(expected)
      end

      it 'handles Oracle JDK 8 package' do
        allow(env_vars).to receive(:http_server_type).and_return("apache")
        expect(env_vars).to receive(:runtime_name).and_return("oracle-jdk")
        allow(env_vars).to receive(:runtime_version).and_return("1.8.0_45")
        allow(env_vars).to receive(:web_server_type).and_return("tomcat")
        expect(env_vars).to receive(:init_type).and_return("")

        expected = [
          "jdk1.8.0_45",
          "httpd",
          "tomcat",
        ]

        expect(subject.resolve_dependencies(env_vars, :centos)).to eq(expected)
      end

      it 'handles OpenJDK package name for centos' do
        allow(env_vars).to receive(:http_server_type).and_return("apache")
        expect(env_vars).to receive(:runtime_name).and_return("openjdk")
        allow(env_vars).to receive(:runtime_version).and_return("1.7.0_80")
        allow(env_vars).to receive(:web_server_type).and_return("tomcat")
        expect(env_vars).to receive(:init_type).and_return("")

        expected = [
          "java-1.7.0-openjdk",
          "httpd",
          "tomcat",
        ]

        expect(subject.resolve_dependencies(env_vars, :centos)).to eq(expected)
      end

      it 'assigns oracle-jre to OpenJDK for debian' do
        allow(env_vars).to receive(:http_server_type).and_return("apache")
        expect(env_vars).to receive(:runtime_name).and_return("oracle-jre")
        allow(env_vars).to receive(:runtime_version).and_return("1.7.0_80")
        allow(env_vars).to receive(:web_server_type).and_return("tomcat")
        expect(env_vars).to receive(:init_type).and_return("")

        expected = [
          "openjdk-7-jre",
          "apache2",
          "tomcat7",
        ]

        expect(subject.resolve_dependencies(env_vars, :debian)).to eq(expected)
      end

      it 'handles OpenJDK package name for debian' do
        allow(env_vars).to receive(:http_server_type).and_return("apache")
        expect(env_vars).to receive(:runtime_name).and_return("openjdk")
        allow(env_vars).to receive(:runtime_version).and_return("1.7.0_80")
        allow(env_vars).to receive(:web_server_type).and_return("tomcat")
        expect(env_vars).to receive(:init_type).and_return("")

        expected = [
          "openjdk-7-jre",
          "apache2",
          "tomcat7",
        ]

        expect(subject.resolve_dependencies(env_vars, :debian)).to eq(expected)
      end
    end
  end
end

