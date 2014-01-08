# encoding: UTF-8

# nicht jetzt
#require 'twitter_cldr'

module Briar
  module Text_Related

    def navigate_to_text_related_tab(opts={})
      default_opts = {:ensure_keyboard_type => :email}
      opts = default_opts.merge(opts)

      unless view_exists? 'text related'
        step_pause
        touch_tabbar_item 'Text'
        wait_for_view 'text related'

        res = query('textView', AI)
        res.concat(query('textField', AI))

        kb_type = opts[:ensure_keyboard_type]
        res.each do |id|
          qstr = "view marked:'#{id}'"
          ensure_keyboard_type(qstr, kb_type)
        end

        step_pause if xamarin_test_cloud?
      end
    end



    def swipe_on_text_field(dir, field)
      if ios7? && simulator?
        pending 'iOS 7 simulator detected: due to a bug in the iOS Simulator, swiping does not work'
      end
      tf = "#{field} tf"
      wait_for_view tf, 2
      swipe(dir, {:query => "textField marked:'#{tf}'"})
      2.times { step_pause }
      tf
    end


    #UIKeyboardTypeDefault,
    #UIKeyboardTypeASCIICapable,
    #UIKeyboardTypeNumbersAndPunctuation,
    #UIKeyboardTypeURL,
    #UIKeyboardTypeNumberPad,
    #UIKeyboardTypePhonePad,
    #UIKeyboardTypeNamePhonePad,
    #UIKeyboardTypeEmailAddress,
    #UIKeyboardTypeDecimalPad,
    #UIKeyboardTypeTwitter,
    #UIKeyboardTypeWebSearch,


    UI_KEYBOARD_TYPE =
          { 0 => :default,
            1 => :ascii_capable,
            2 => :numbers_and_punctuation,
            3 => :url,
            4 => :number_pad,
            5 => :phone_pad,
            6 => :name_phone_pad,
            7 => :email,
            8 => :decimal,
            9 => :twitter,
            10 => :web_search }


    def canonical_keyboard_type(ui_keyboard_type)
      if ui_keyboard_type.is_a?(Fixnum)
        UI_KEYBOARD_TYPE[ui_keyboard_type]
      else
        raise "expected '#{ui_keyboard_type}' to be a Fixnum"
      end
    end

    def ui_keyboard_type(canonical_keyboard_type)
      if canonical_keyboard_type.is_a?(Symbol)
        Hash[UI_KEYBOARD_TYPE.map(&:reverse)][canonical_keyboard_type]
      else
        raise "expected '#{canonical_keyboard_type}' to be a Symbol"
      end
    end


    def keyboard_type_with_query(query_str, opts={})
      default_opts = {:timeout_message => "after waiting '#{query_str}' did not find a match"}
      opts = default_opts.merge(opts)

      res = nil

      wait_for(opts) do
        res = query(query_str, :keyboardType)
        not res.nil?
      end

      unless res.count == 1
        screenshot_and_raise "expected exactly one element to be returned by '#{query_str}' but found '#{res}'"
      end

      canonical_keyboard_type(res.first)
    end

    def ensure_keyboard_type(query_str, type, opts={})
      target_ui_type = ui_keyboard_type(type)
      if target_ui_type.nil?
        raise "expected '#{type}' to be a valid canonical type for '#{UI_KEYBOARD_TYPE}'"
      end

      current = keyboard_type_with_query(query_str, opts)
      unless current.eql?(type)
        res = query("#{query_str}", {:setKeyboardType => target_ui_type})
        if res.empty?
          screenshot_and_raise "could not set keyboard type for '#{query_str}' to '#{target_ui_type}' found '#{res}'"
        end
      end
    end

    def text_from_first_responder(ui_class)
      candidates = [:text_view, :text_field]
      unless candidates.include?(ui_class)
        raise "'#{ui_class}' must be one of '#{candidates}'"
      end

      qstr = ui_class == :text_view ? 'textView' : 'textField'
      qstr = "#{qstr} isFirstResponder:1"

      res = query(qstr, :text)
      if res.empty?
        screenshot_and_raise "could not find a first responder with '#{qstr}'"
      end

      res.first
    end

    def ensure_text_input(str, input_method)
      keyboard_enter_text str
      step_pause if xamarin_test_cloud?
      actual = text_from_first_responder(:text_field)
      unless actual.eql?(str)
        screenshot_and_raise "expected '#{str}' after #{input_method} but found '#{actual}'"
      end
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
  wait_for_keyboard
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
  wait_for_keyboard

  is_ipad = ipad?
  is_iphone = iphone?

  num.to_i.times {
    rnd_str = ''
    str_len = 50
    str_len.enum_for(:times).inject(rnd_str) do |result, index|
      code = [*32..126].sample
      sample = code.chr


      # ( ) : ; #=> these do not exist on the ipad _simulator_ email keyboard
      #     ( ) #=> these do not exist on the ipad email keyboard
      #     ‹ › #=> these do not exist on some ipad keyboards
      #      `  #=> does not exist on the ipad email keyboard
      #      `  #=> does not exist on the iphone email keyboard
      #       \ #=> too annoying to test (backslash)
      if is_ipad
        sample = '{' if sample.eql?('(')
        sample = '}' if sample.eql?(')')
        sample = '¥' if sample.eql?(':')
        sample = '£' if sample.eql?(';')
        sample = '!' if sample.eql?('`')
        sample = '€' if sample.eql?('\\')
      elsif is_iphone
        sample = '|' if sample.eql?('(')
        sample = '&' if sample.eql?(')')
        # double quote - having some problems with .eql?("\"")
        sample = '#' if sample.ord == 34
        sample = '^' if sample.eql?(':')
        sample = '!' if sample.eql?(';')
        sample = '+' if sample.eql?('<')
        sample = '_' if sample.eql?('>')
        sample = '.' if sample.eql?('\\')
        sample = '@' if sample.eql?(',')
      else
        screenshot_and_raise 'not iphone or ipad?!?'
      end

      rnd_str << sample
    end


    # why oh why was i doing this?
    # rnd_str.insert(rand(str_len), ',')


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
  wait_for_keyboard


  # cannot enter text on split ipad keyboard with UIA
  # so we choose a random keyboard mode
  if ipad? and uia_not_available? and (:split == ipad_keyboard_mode)
    [true, false].sample ? ensure_docked_keyboard : ensure_undocked_keyboard
  end

  num.to_i.times {
    email = Faker::Internet.email
    tokens = email.split('@')
    num = [*0..3030].sample
    name = "#{tokens.first}#{num}".split('').shuffle().join('')
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
  if ipad?
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
  wait_for_keyboard
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

And(/^the top text field has (?:a|an|the) (default|ascii|numbers and punctuation|url|number|phone|name and phone|email|decimal|twitter|web search) (?:keyboard|pad) showing$/) do |kb_type|
  qstr = "textField marked:'top tf'"

  case kb_type
    when 'ascii' then target = :ascii_capable
    when 'number' then target = :number_pad
    when 'phone' then target = :phone_pad
    when 'name and phone' then target = :name_phone_pad
    else target = "#{kb_type.gsub(' ', '_')}".to_sym
  end

  ensure_keyboard_type(qstr, target)
  touch(qstr)
  wait_for_keyboard
  step_pause if xamarin_test_cloud?
end

Then(/^set my pin to "([^"]*)"$/) do |pin|
  keyboard_enter_text pin
end

When(/^I tap the delete key (\d+) times?, I should see "([^"]*)" in the text field$/) do |num_taps, result|
  before = text_from_first_responder(:text_field)
  num = num_taps.to_i

  num.times {  keyboard_enter_char 'Delete' }

  step_pause if xamarin_test_cloud?

  idx = (before.length - num) - 1
  expected = before[0..idx]
  actual = text_from_first_responder(:text_field)

  unless actual.eql?(expected)
    screenshot_and_raise "expected '#{expected}' after tapping the delete key '#{num}' times but found '#{actual}'"
  end
end

Then(/^I text my friend a facepalm "([^"]*)"$/) do |str|
  ensure_text_input str, 'texting'
end

And(/^realize my mistake and delete (\d+) characters? and replace with "([^"]*)"$/) do |num_taps, replacement|
  before = text_from_first_responder(:text_field)
  num = num_taps.to_i

  num.times {  keyboard_enter_char 'Delete' }

  step_pause if xamarin_test_cloud?

  idx = (before.length - num) - 1
  expected = "#{before[0..idx]}#{replacement}"

  keyboard_enter_text(replacement)

  step_pause if xamarin_test_cloud?

  actual = text_from_first_responder(:text_field)

  unless actual.eql?(expected)
    screenshot_and_raise "expected '#{expected}' after tapping the delete key '#{num}' times but found '#{actual}'"
  end
end

Then(/^I type "([^"]*)"$/) do |str|
  ensure_text_input str, 'typing'
end

Then(/^dial "([^"]*)"$/) do |str|
  ensure_text_input str, 'dialing'
end

Then(/^I try to visit "([^"]*)"$/) do |str|
  ensure_text_input str, 'typing'
end

Then(/^I change my pin to "([^"]*)"$/) do |arg|
  ensure_text_input arg, 'typing'
end

Then(/^I say, "([^"]*)" that's my number$/) do |arg|
  ensure_text_input arg, 'shouting'
end

Then(/^try to call "([^"]*)" at "([^"]*)"$/) do |who, number|
  str = "#{who} #{number}"
  ensure_text_input str, 'typing'
end

Then(/^I start to send an email to "([^"]*)"$/) do |str|
  ensure_text_input str, 'typing'
end

Then(/^I type pi as "([^"]*)"$/) do |str|
  # requires twitter_cldr
  # not ready for prime time - requires a calabash server update to provide
  # current phone locale
  #pi = str.to_f
  #str = pi.localize(:de).to_s
  begin
    ensure_text_input str, 'typing'
  rescue
    pending("will fail if device locale uses ',' for decimal sep")
  end
end

Then(/^I tweet "([^"]*)" and tag with with "([^"]*)"$/) do |tweet, hash_tag|
  str = "#{tweet} #{hash_tag}"
  ensure_text_input str, 'tweeting'
end

Then(/^search for "([^"]*)"$/) do |str|
  ensure_text_input str, 'searching'
end