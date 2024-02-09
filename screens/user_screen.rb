# IOSUserScreen
# user Screen for iOS
class IOSUserScreen
  def message
    [
      :xpath,
      "//XCUIElementTypeOther[contains(@name, 'You are logged')]"
    ]
  end

  def initialize
    log.info "initializing #{self.class}"
  end

  def get_logged_in_user
    message = apm.driver.wait { apm.driver.find_element(*self.message) }.text
    message.split[-2]
  end
end

# AndroidUserScreen
# user Screen for android
class AndroidUserScreen < IOSUserScreen
  def message
    [:xpath,
     "//android.widget.TextView[contains(@text, 'You are logged')]"]
  end

  def get_logged_in_user
    message = apm.driver.wait { apm.driver.find_element(*self.message) }.text
    message.split.last
  end
end
