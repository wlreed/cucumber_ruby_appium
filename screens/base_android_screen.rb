# BaseAndroidScreen
# base screen for all android screens
class BaseAndroidScreen < BaseScreen
  def back_button
    find_element_by_tag('android.widget.ImageButton')
  end
end
