require 'spec_helper'

describe Gordon::Cookery::Log do
  subject do
    class MyLog
      include Gordon::Cookery::Log
    end.new
  end

  let(:app_name)  { "gordon" }
  let(:log_path)  { "/var/log/#{app_name}" }
  let(:env_vars)  { instance_double Gordon::EnvVars }

  it 'creates folder' do
    expect(env_vars).to receive(:app_name).and_return(app_name)

    path_helper = instance_double 'A fpm cookery path helper'
    expect(subject).to receive(:root).with(log_path).and_return(path_helper)
    expect(path_helper).to receive(:mkdir)

    subject.create_log_folder(env_vars)
  end
end

