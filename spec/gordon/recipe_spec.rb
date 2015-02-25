require 'spec_helper'

describe Gordon::Recipe do
  let(:options)   { instance_double Gordon::Options, app_type: :ruby_web_app }
  let(:app_type)  { Gordon::Application::Types::RubyWebApp.new }

  subject do
    described_class.new(options)
  end

  describe 'creating a new instance' do
    it 'maps a new instance of application' do
      expect(subject.application).to be_instance_of(app_type.class)
    end
  end

  # TODO: check if is really needed
  describe 'getting a platform' do
    pending
  end

  # TODO: check if is really needed
  describe 'checking if requires platform' do
    pending
  end

  describe 'getting application template path' do
    it 'returns expected path based on app type' do
      expect(subject.application_template_path).to eq(app_type.get_template_path)
    end
  end
end

