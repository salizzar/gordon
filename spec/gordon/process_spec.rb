require 'spec_helper'

describe Gordon::Process do
  let(:command) { 'uname -a' }
  let(:pid)     { 3329 }

  describe 'running a command' do
    before :each do
      expect(Process).to receive(:spawn).with(command, out: $stdout, err: $stderr).and_return(pid)
    end

    it 'spawns and waits for execution' do
      expect(Process).to receive(:wait2).with(pid).and_return([ pid, 0 ])

      expect(described_class.run(command)).to be_truthy
    end

    it 'raises error if call returns one' do
      expect(Process).to receive(:wait2).with(pid).and_return([ pid, 1 ])

      expect{ described_class.run(command) }.to raise_error(SystemCallError)
    end
  end
end

