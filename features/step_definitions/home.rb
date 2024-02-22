Given(/^I click (.*) on home screen$/) do |button|
  home_screen = screen_factory.fetch_current_screen
  home_screen.send("click_#{button}_button")
end
