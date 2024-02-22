# HomeScreen
# represents first screen of app
class HomeScreen < BaseScreen
  def initialize
    @element_map = {
      login: [:accessibility_id, 'Login Screen'],
      echo_box: [:accessibility_id, 'Echo Box']
    }
    super
  end

  def login_button
    find_element(*@element_map[:login])
  end

  def echo_box_button
    find_element(*@element_map[:echo_box])
  end
end
