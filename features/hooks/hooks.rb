at_exit do
  log.info 'quitting driver and server'
  apm.driver.driver_quit
  apm_server.stop_server
end

After('@click_back') do
  current_screen = screen_factory.fetch_current_screen
  while current_screen.class.method_defined? :back_button
    current_screen.click_back_button
    current_screen = screen_factory.fetch_current_screen
  end
end
