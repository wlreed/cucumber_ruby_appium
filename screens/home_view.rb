# HomeView
# represents first screen of app
class HomeView
  def initialize(driver)
    @d = driver
    @login = [
      :accessibility_id,
      'Login Screen'
    ]
  end

  def nav_to_login
    @d.wait { @d.find_element(*@login) }.click
  end
end
