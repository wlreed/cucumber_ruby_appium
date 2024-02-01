# IOSUserView
# user view for iOS
class IOSUserView
  def message
    [
      :xpath,
      "//XCUIElementTypeOther[contains(@name, 'You are logged')]"
    ]
  end

  def initialize(driver)
    @d = driver
  end

  def get_logged_in_user
    message = @d.wait { @d.find_element(*self.message) }.text
    message.split[-2]
  end
end

# AndroidUserView
# user view for android
class AndroidUserView < IOSUserView
  def message
    [:xpath,
     "//android.widget.TextView[contains(@text, 'You are logged')]"]
  end

  def get_logged_in_user
    message = @d.wait { @d.find_element(*self.message) }.text
    message.split.last
  end
end
