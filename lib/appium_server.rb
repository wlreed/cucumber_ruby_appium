require 'singleton'
# AppiumServer
# functionality for starting, stopping, and
# maintaining appium server
class AppiumServer
  include Singleton
  attr_accessor :server_pid

  def setup
    @server_args = 'appium --base-path /wd/hub'
  end

  def start_server(log_dir)
    log_file = "#{log_dir}/appium-server.txt"
    @server_pid = spawn(@server_args, err: :out, out: [log_file, 'w'])
    log.info "Appium server log is: #{log_file}"
  end

  def stop_server
    Process.kill(9, @server_pid)
  end
end

def apm_server
  AppiumServer.instance
end
