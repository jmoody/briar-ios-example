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

  num.to_i.times {
    rnd_str = ''
    str_len = 50
    str_len.enum_for(:times).inject(rnd_str) do |result, index|
      sample = [*32..126].sample.chr
      # these do not exist on the email keyboard
      sample = '‹' if sample.eql?('(')
      sample = '›' if sample.eql?(')')
      sample = '¥' if sample.eql?(':')
      sample = '£' if sample.eql?(';')
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

  num.to_i.times {
    email = Faker::Internet.email
    tokens = email.split('@')
    num = [*0..3030].sample
    name = "#{tokens.first}#{num}".chars.shuffle().join('')
    email = "#{name}@#{tokens[1]}"

    keyboard_enter_text email
    should_see_text_field_with_text tf_id, email
    clear_text("view marked:'#{tf_id}'")

    tf_id = tf_ids.sample
    touch("textField marked:'#{tf_id}'")
    step_pause
  }
end

