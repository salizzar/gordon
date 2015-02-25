module Gordon
  class Process
    def self.run(command)
      pid = ::Process.spawn(command, out: $stdout, err: $stderr)
      _, exit_status = ::Process.wait2(pid)

      raise SystemCallError.new("Failed to execute [#{command}]. Exit code: #{exit_status}") unless exit_status == 0

      true
    end
  end
end

