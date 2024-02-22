# EchoBoxScreen
# represents first screen of app
class EchoBoxScreen < BaseScreen
  def initialize
    @element_map = {
      say_something: [:accessibility_id, 'messageInput'],
      message_save: [:accessibility_id, 'messageSaveBtn']
    }
    super
  end

  def say_something_button
    find_element(*@element_map[:say_something])
  end

  def message_save_button
    find_element(*@element_map[:message_save])
  end
end
