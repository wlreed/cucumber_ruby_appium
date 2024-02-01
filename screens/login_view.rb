# LoginView
# sample login view
class LoginView
  def initialize(driver)
    @d = driver
    @username = [
      :accessibility_id,
      'username'
    ]

    @password = [
      :accessibility_id,
      'password'
    ]

    @login_btn = [
      :accessibility_id,
      'loginBtn'
    ]
  end

  def login(username, password)
    @d.wait { @d.find_element(*@username) }.send_keys(username)
    @d.find_element(*@password).send_keys(password)
    @d.find_element(*@login_btn).click
  end
end
