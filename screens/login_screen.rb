# LoginScreen
# sample login Screen
module LoginScreen
  def login(username, password)
    user_name = find_element(*@element_map[:username])
    user_name.send_keys(username)
    find_element(*@element_map[:password]).send_keys(password)
    click_login_button
  end

  def login_button
    find_element(*@element_map[:login_btn])
  end
end

# IOSLoginScreen < BaseIOSScreen
# login screen for ios
class IOSLoginScreen < BaseIOSScreen
  include LoginScreen
  def initialize
    @element_map = {
      username: [:accessibility_id, 'username'],
      password: [:accessibility_id, 'password'],
      login_btn: [:accessibility_id, 'loginBtn']
    }
    super
  end
end

# AndroidLoginScreen
# overrides methods specific to Android
class AndroidLoginScreen < BaseAndroidScreen
  include LoginScreen
  def initialize
    @element_map = {
      username: [:accessibility_id, 'username'],
      password: [:accessibility_id, 'password'],
      login_btn: [:accessibility_id, 'loginBtn']
    }
    super
  end
end
