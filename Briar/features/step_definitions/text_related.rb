module Briar
  module Text_Related
    def swipe_on_text_field(dir, field)
      dev = device
      if dev.ios7? && dev.simulator?
        pending 'iOS 7 simulator detected: due to a bug in the iOS Simulator, swiping does not work'
      end
      tf = "#{field} tf"
      wait_for_view tf, 2
      swipe(dir, {:query => "textField marked:'#{tf}'"})
      2.times { step_pause }
      tf
    end
  end
end

World(Briar::Text_Related)

Then(/^I swipe (left|right) on the (top|bottom) text field$/) do |dir, field|
  swipe_on_text_field dir, field
end

And(/^I have touched the "([^"]*)" text field$/) do |text_field|
  text_fields = ['top', 'bottom']
  unless text_fields.include? text_field
    screenshot_and_raise "expected '#{text_field}' to be one of '#{text_fields}'"
  end
  tf_id = "#{text_field} tf"
  touch("textField marked:'#{tf_id}'")
  await_keyboard
end

Then(/^I should see the (top|bottom) text field has "([^"]*)"$/) do |field, text|
  tf = "#{field} tf"
  should_see_text_field_with_text tf, text
  warn "status bar orientation = '#{status_bar_orientation}'"
  2.times { step_pause }
end


Then(/^I type (\d+) random strings? with the full range of characters into the text fields$/) do |num|
  # just start with the top and alternate
  tf_ids = ['top tf', 'bottom tf']
  tf_id = tf_ids.first
  touch("textField marked:'#{tf_id}'")
  await_keyboard

  is_ipad = ipad?
  is_iphone = iphone?

  is_simulator = simulator?
  num.to_i.times {
    rnd_str = ''
    str_len = 50
    str_len.enum_for(:times).inject(rnd_str) do |result, index|
      sample = [*32..126].sample.chr
      # ( ) : ; #=> these do not exist on the ipad _simulator_ email keyboard
      #     ( ) #=> these do not exist on the ipad email keyboard
      #     ‹ › #=> these do not exist on some ipad keyboard
      #      `  #=> does not exist on the ipad email keyboard
      #      `  #=> does not exist on the iphone email keyboard
      #       \ #=> too annoying to test (backslash)
      if is_ipad
          sample = '{' if sample.eql?('(')
          sample = '}' if sample.eql?(')')
          sample = '¥' if sample.eql?(':')
          sample = '£' if sample.eql?(';')
          sample = '!' if sample.eql?('`')
      elsif is_iphone
        unless is_simulator
          sample = '¥' if sample.eql?('`')
        end
      else
        screenshot_and_raise 'not iphone or ipad?!?'
      end
      sample = '€' if sample.eql?('\\')
      #sample = '·' if sample.eql?('\"')
      rnd_str << sample
    end

    rnd_str.insert(rand(str_len), ',')


    keyboard_enter_text rnd_str
    should_see_text_field_with_text tf_id, rnd_str
    clear_text("view marked:'#{tf_id}'")

    tf_id = tf_ids.sample
    touch("textField marked:'#{tf_id}'")
    step_pause
  }
end


Then(/^I type (\d+) email (?:addresses|address) into the text fields$/) do |num|
  # just start with the top and alternate
  tf_ids = ['top tf', 'bottom tf']
  tf_id = tf_ids.first
  touch("textField marked:'#{tf_id}'")
  await_keyboard

  # cannot enter text on split ipad keyboard with UIA
  if uia_not_available? and ipad? and (:split == ipad_keyboard_mode)
    if [true, false].sample
      ensure_docked_keyboard
    else
      ensure_undocked_keyboard
    end
  end

  num.to_i.times {
    email = Faker::Internet.email
    tokens = email.split('@')
    num = [*0..3030].sample
    name = "#{tokens.first}#{num}".chars.shuffle().join('')
    email = "#{name}@#{tokens[1]}"

    keyboard_enter_text email
    should_see_text_field_with_text tf_id, email
    clear_text("view marked:'#{tf_id}'")
    2.times { step_pause }

    tf_id = tf_ids.sample
    touch("textField marked:'#{tf_id}'")
    res = query("textField marked:'#{tf_id}'", AI)
    puts "touched '#{res.first}'"

    1.times { step_pause }
  }
end

Then(/^I check the keyboard mode is stable across orientations$/) do
  orientations = [:up, :down, :left, :right]
  rotate_home_button_to orientations.sample
  2.times { step_pause }
  target_mode = ipad_keyboard_mode
  orientations.each { |o|
    rotate_home_button_to o
    2.times { step_pause }
    mode = ipad_keyboard_mode
    unless target_mode == mode
      screenshot_and_raise "expected '#{target_mode}' in orientation '#{o}' but found '#{mode}'"
    end
  }
  2.times { step_pause }
end

Then(/^I should be able to (dock|undock|split) the keyboard$/) do |op|
  case op
    when 'dock'
      ensure_docked_keyboard
    when 'undock'
      ensure_undocked_keyboard
    when 'split'
      ensure_split_keyboard
    else
      screenshot_and_raise "expected '#{op}' to be one of ['dock', 'undock', 'split']"
  end
end


Then(/^I put the keyboard into a random mode$/) do
  await_keyboard
  mode = _ipad_keyboard_modes.sample
  case mode
    when :docked
      ensure_docked_keyboard
    when :undocked
      ensure_undocked_keyboard
    when :split
      ensure_split_keyboard
    else
      screenshot_and_raise "expected '#{mode}' to be one of '#{_ipad_keyboard_modes}'"
  end
end

Then(/^I should be able to dismiss the ipad keyboard$/) do
  if ipad?
    dismiss_ipad_keyboard
  end
end