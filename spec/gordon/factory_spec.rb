require 'spec_helper'

describe Gordon::Factory do
  describe 'creating a instance of some object' do
    it 'returns a new instance of a skeleton' do
      namespace, object_type = "Skeleton::Types", "systemd"

      result = described_class.create_instance(namespace, object_type)

      expect(result).to be_instance_of(Gordon::Skeleton::Types::Systemd)
    end

    it 'returns a new instance of a application type' do
      namespace, object_type = "Application::Types", "ruby_web_app"

      result = described_class.create_instance(namespace, object_type)

      expect(result).to be_instance_of(Gordon::Application::Types::RubyWebApp)
    end
  end
end

