Given('I click login on home screen') do
  @home_view = HomeView.new(apm.driver)
  @home_view.nav_to_login
end

Given('I enter valid username and password') do
  @login_view = LoginView.new(apm.driver)
  @login_view.login('alice', 'mypassword')
end

Then('I should see that I am logged in with username') do
  @user_view = if apm.caps[:caps][:platformName].downcase == 'ios'
                 IOSUserView.new(apm.driver)
               else
                 AndroidUserView.new(apm.driver)
               end
  user = @user_view.get_logged_in_user
  expect(user).to eq('alice')
end
