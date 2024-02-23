# EchoBoxScreen
# represents first screen of app
module EchoBoxScreen
  def say_something_button
    find_element(*@element_map[:say_something])
  end

  def message_save_button
    find_element(*@element_map[:message_save])
  end

  def fetch_saved_message(text)
    find_element(:accessibility_id, text)
  end
end

# IOSEchoBoxScreen
class IOSEchoBoxScreen < BaseIOSScreen
  include EchoBoxScreen
  def initialize
    @element_map = {
      say_something: [:accessibility_id, 'messageInput'],
      message_save: [:accessibility_id, 'messageSaveBtn']
    }
    super
  end

  def fetch_saved_message(text)
    find_element(:accessibility_id, "Here's what you said before: #{text}")
  end
end

# AndroidEchoBoxScreen
class AndroidEchoBoxScreen < BaseAndroidScreen
  include EchoBoxScreen
  def initialize
    @element_map = {
      say_something: [:accessibility_id, 'messageInput'],
      message_save: [:accessibility_id, 'messageSaveBtn']
    }
    super
  end
end
