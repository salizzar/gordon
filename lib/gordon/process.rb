module Gordon
  class Process
    def self.run(command)
      pid = ::Process.spawn(command, out: $stdout, err: $stderr)
      _, status = ::Process.wait2(pid)
    end
  end
end

