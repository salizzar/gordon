require 'spec_helper'

describe Gordon::Application::Types::Base do
  subject do
    class MyApplicationTypesBase
      include Gordon::Application::Types::Base

      def get_template ; 'vudu_eh_pra_jacoo' ; end
    end

    MyApplicationTypesBase.new
  end

  it 'returns template path based on class' do
    path = '/a/strange/path'
    curdir = File.join(path, 'lib', 'gordon')
    expect(File).to receive(:dirname).and_return(curdir)

    expected = File.join(curdir, 'templates', 'vudu_eh_pra_jacoo.rb')

    expect(subject.get_template_path).to eq(expected)
  end
end

describe Gordon::Application::Types::RubyWebApp do
  it 'returns a template' do
    expect(subject.get_template).to eq('ruby_web_app')
  end
end

describe Gordon::Application::Types::RubyStandaloneApp do
  it 'returns a template' do
    expect(subject.get_template).to eq('ruby_standalone_app')
  end
end

describe Gordon::Application::Types::JavaWebApp do
  it 'returns a template' do
    expect(subject.get_template).to eq('java_web_app')
  end
end

describe Gordon::Application::Types::JavaStandaloneApp do
  it 'returns a template' do
    expect(subject.get_template).to eq('java_standalone_app')
  end
end

