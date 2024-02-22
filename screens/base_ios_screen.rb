# BaseIOSScreen
# base screen for all ios screens
class BaseIOSScreen < BaseScreen
  def back_button
    log.info 'Clicking back_button in base_screen'
    find_element_by_name_and_type('TheApp', 'XCUIElementTypeButton')
  end
end
