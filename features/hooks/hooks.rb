at_exit do
  log.info 'quitting driver and server'
  apm.driver.driver_quit
  apm_server.stop_server
end
