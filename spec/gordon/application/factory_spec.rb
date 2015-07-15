require 'spec_helper'

describe Gordon::Application::Factory do
  let(:options) { instance_double(Gordon::Options) }

  shared_examples_for 'a instance of specified runtime and type' do |expected_class|
    it 'returns a instance of specified runtime and type' do
      expect(described_class.create(options)).to be_instance_of(expected_class)
    end
  end

  describe 'ruby' do
    before :each do
      allow(options).to receive(:runtime_name).and_return(:ruby)
    end

    context 'web' do
      before :each do
        allow(options).to receive(:app_type).and_return(:web)
      end

      it_behaves_like 'a instance of specified runtime and type', Gordon::Application::Types::RubyWebApp
    end

    context 'standalone' do
      before :each do
        allow(options).to receive(:app_type).and_return(:standalone)
      end

      it_behaves_like 'a instance of specified runtime and type', Gordon::Application::Types::RubyStandaloneApp
    end
  end

  describe 'java' do
    before :each do
      allow(options).to receive(:runtime_name).and_return('oracle-jdk')
    end

    context 'web' do
      before :each do
        allow(options).to receive(:app_type).and_return(:web)
      end

      it_behaves_like 'a instance of specified runtime and type', Gordon::Application::Types::JavaWebApp
    end

    context 'standalone' do
      before :each do
        allow(options).to receive(:app_type).and_return(:standalone)
      end

      it_behaves_like 'a instance of specified runtime and type', Gordon::Application::Types::JavaStandaloneApp
    end
  end
end

