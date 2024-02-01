at_exit do
  puts 'quitting driver and server'
  apm.driver.driver_quit
  apm_server.stop_server
end
