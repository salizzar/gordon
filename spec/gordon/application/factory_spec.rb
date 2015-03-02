require 'spec_helper'

describe Gordon::Application::Factory do
  let(:options) { instance_double Gordon::Options, app_type: :web, runtime_name: :java }

  it 'returns a instance of specified runtime and type' do
    expect(described_class.create(options)).to be_instance_of(Gordon::Application::Types::JavaWebApp)
  end
end

