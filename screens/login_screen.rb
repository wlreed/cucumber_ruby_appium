# LoginScreen
# sample login Screen
class LoginScreen
  def initialize
    puts "initializing #{self.class}"

    @element_map = {
      username: [:accessibility_id, 'username'],
      password: [:accessibility_id, 'password'],
      login_btn: [:accessibility_id, 'loginBtn']
    }
  end

  def login(username, password)
    user_name = apm.driver.wait { apm.driver.find_element(*@element_map[:username]) }
    user_name.send_keys(username)
    apm.driver.find_element(*@element_map[:password]).send_keys(password)
    apm.driver.find_element(*@element_map[:login_btn]).click
  end
end
