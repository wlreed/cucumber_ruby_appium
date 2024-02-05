# HomeScreen
# represents first screen of app
class HomeScreen
  def initialize
    puts "initializing #{self.class}"
    @element_map = {
      login: [:accessibility_id, 'Login Screen']
    }
  end

  def nav_to_login
    apm.driver.wait { apm.driver.find_element(*@element_map[:login]) }.click
  end
end
