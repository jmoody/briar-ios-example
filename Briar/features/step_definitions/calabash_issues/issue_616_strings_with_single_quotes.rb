And(/^I type a contraction in the top text field$/) do
  qstr = "UITextField marked:'top tf'"
  wait_for_query qstr
  touch qstr
  wait_for_keyboard
  keyboard_enter_text "wasn't"
end

Then(/^I should see the contraction has been typed correctly$/) do
  actual = text_from_first_responder
  expected = "wasn't"
  unless expected == actual
    raise "Expected '#{expected}' to be typed but found '#{actual}'"
  end
end
