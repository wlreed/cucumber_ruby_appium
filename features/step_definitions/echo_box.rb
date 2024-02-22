Then(/^I should see that I am on the echo_box screen$/) do
  echo_box_screen = screen_factory.fetch_current_screen
  expect(echo_box_screen).to be_a(EchoBoxScreen)
end

And(/^I enter some text$/) do
  echo_box_screen = screen_factory.fetch_current_screen
  echo_box_screen.say_something_button.send_keys('alice was here')
  echo_box_screen.send('click_message_save_button')
end
