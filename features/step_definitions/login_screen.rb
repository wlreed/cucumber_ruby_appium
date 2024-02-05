Given('I enter valid username and password') do
  login_screen = screen_factory.fetch_current_screen
  login_screen.login('alice', 'mypassword')
end

Then('I should see that I am logged in with username') do
  user_screen = screen_factory.fetch_current_screen
  user = user_screen.get_logged_in_user
  expect(user).to eq('alice')
end
