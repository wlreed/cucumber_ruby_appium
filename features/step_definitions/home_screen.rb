Given('I click login on home screen') do
  home_screen = screen_factory.fetch_current_screen
  home_screen.nav_to_login
end
