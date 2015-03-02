require 'spec_helper'

describe Gordon::Recipe do
  let(:options)   { instance_double Gordon::Options, app_type: :web, runtime_name: :ruby }
  let(:app_type)  { Gordon::Application::Types::RubyWebApp.new }

  subject do
    described_class.new(options)
  end

  describe 'creating a new instance' do
    it 'maps a new instance of application' do
      expect(subject.application).to be_instance_of(app_type.class)
    end
  end

  describe 'getting application template path' do
    it 'returns expected path based on app type' do
      expect(subject.application_template_path).to eq(app_type.get_template_path)
    end
  end
end

