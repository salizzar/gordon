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
        expect(env_vars).to receive(:app_type).and_return("ruby_web_app")
        expect(env_vars).to receive(:runtime_version).and_return("2.2.0")
        allow(env_vars).to receive(:http_server_type).and_return("apache")
        expect(env_vars).to receive(:web_server_type).and_return("")
        allow(env_vars).to receive(:init_type).and_return("systemd")

        expected = [
          "ruby = 2.2.0",
          "httpd",
          "systemd",
        ]

        expect(subject.resolve_dependencies(env_vars)).to eq(expected)
      end

      it 'returns all dependencies for standalone' do
        expect(env_vars).to receive(:app_type).and_return("ruby_standalone_app")
        expect(env_vars).to receive(:runtime_version).and_return("2.1.5")
        expect(env_vars).to receive(:http_server_type).and_return("")
        expect(env_vars).to receive(:web_server_type).and_return("")
        allow(env_vars).to receive(:init_type).and_return("systemd")

        expected = [
          "ruby = 2.1.5",
          "systemd",
        ]

        expect(subject.resolve_dependencies(env_vars)).to eq(expected)
      end
    end

    context 'given a java standalone app' do
      it 'returns all dependencies for web' do
        expect(env_vars).to receive(:app_type).and_return("java_web_app")
        allow(env_vars).to receive(:http_server_type).and_return("apache")
        allow(env_vars).to receive(:runtime_version).and_return("1.7.0_60")
        allow(env_vars).to receive(:web_server_type).and_return("tomcat")
        expect(env_vars).to receive(:init_type).and_return("")

        expected = [
          "jre = 1.7.0_60",
          "httpd",
          "tomcat",
        ]

        expect(subject.resolve_dependencies(env_vars)).to eq(expected)
      end

      it 'handles damn Oracle JRE 8 package name' do
        expect(env_vars).to receive(:app_type).and_return("java_web_app")
        allow(env_vars).to receive(:http_server_type).and_return("apache")
        allow(env_vars).to receive(:runtime_version).and_return("1.8.0_25")
        allow(env_vars).to receive(:web_server_type).and_return("tomcat")
        expect(env_vars).to receive(:init_type).and_return("")

        expected = [
          "jre1.8.0_25",
          "httpd",
          "tomcat",
        ]

        expect(subject.resolve_dependencies(env_vars)).to eq(expected)
      end
    end
  end
end

