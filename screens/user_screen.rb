# IOSUserScreen
# user Screen for iOS
class IOSUserScreen < BaseIOSScreen
  def initialize
    @element_map = {
      message: [:xpath, "//XCUIElementTypeOther[contains(@name, 'You are logged')]"],
      back: %w[Back XCUIElementTypeButton]
    }
    super
  end

  def get_logged_in_user
    message = find_element(*@element_map[:message]).text
    message.split[-2]
  end

  def back_button
    find_element_by_name_and_type(*@element_map[:back])
  end
end

# AndroidUserScreen
# user Screen for android
class AndroidUserScreen < BaseAndroidScreen
  def initialize
    @element_map = {
      message: [:xpath, "//android.widget.TextView[contains(@text, 'You are logged')]"],
      back: [:xpath, 'android.widget.ImageButton']
    }
    super
  end

  def get_logged_in_user
    message = find_element(*@element_map[:message]).text
    message.split.last
  end
end
