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

    def text_from_first_responder
      raise 'there must be a visible keyboard' unless keyboard_visible?

      ['textField', 'textView'].each do |ui_class|
        res = query("#{ui_class} isFirstResponder:1", :text)
        return res.first unless res.empty?
      end
      #noinspection RubyUnnecessaryReturnStatement
      return nil
    end

    def ensure_text_input(str, input_method, opts={})
      default_opts = {:case_insensitive => false}
      opts = default_opts.merge(opts)

      keyboard_enter_text str
      actual = text_from_first_responder()

      if opts[:case_insensitive]
        unless actual.downcase.eql?(str.downcase)
          screenshot_and_raise "expected '#{str}' == '#{actual}' (case insensitive) after #{input_method}"
        end
      else
        unless actual.eql?(str)
          screenshot_and_raise "expected '#{str}' after #{input_method} but found '#{actual}'"
        end
      end
    end

    def text_field_qstrs
      ["textField marked:'top tf'",
       "textField marked:'bottom tf'"]
    end

    def text_view_qstrs
      ["textView marked:'top tv'",
       "textView marked:'bottom tv'"]
    end


    def text_input_view_qstrs
      text_view_qstrs.concat(text_field_qstrs)
    end


    def qstr_for_random_text_input_view
      @current_text_input_view = text_input_view_qstrs.sample()
    end

    def qstr_for_random_text_field
      @current_text_input_view = text_field_qstrs.sample()
    end

    def qstr_for_random_text_view
      @current_text_input_view = text_view_qstrs.sample()
    end


    def current_text_input_view_is_text_view?
      expect_current_text_input_view_set
      tokens = @current_text_input_view.split(' ')
      tokens[0] == 'textView'
    end

    def expect_current_text_input_view_set
      unless @current_text_input_view
        screenshot_and_raise 'expected that @current_text_input_view would not be nil'
      end
    end

    def unescape_backslashes(string)
      if uia_available?
        if string.index(/\\/)
          string = string.gsub!('\\\\','\\')
        end
      end
      string
    end

  end
end

World(Briar::Text_Related)

Then(/^I swipe (left|right) on the (top|bottom) text field$/) do |dir, field|

  if ios8? and not simulator?
    if xamarin_test_cloud?
      raise "Requires a fix that is not available yet.\nSee: https://github.com/calabash/calabash-ios/issues/613"
    else
      pending "Requires a fix that is not available yet.\nSee: https://github.com/calabash/calabash-ios/issues/613"
    end
  else
    swipe_on_text_field dir, field
  end
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

Then(/^I should see the (top|bottom|user|pass) text field has "([^"]*)"$/) do |field, text|
  tf = "#{field} tf"
  should_see_text_field_with_text tf, text
  2.times { step_pause }
end


Then(/^I type "([^"]*)" into the (user|pass) text field$/) do |text, field|
  tf = "#{field} tf"
  touch("textField marked:'#{tf}'")
  wait_for_keyboard

  keyboard_enter_text text
  touch("button marked:'done text editing'")
end


Then(/^I type (\d+) random strings? with the full range of characters into the text fields$/) do |num|
  # just start with the top and alternate
  tf_ids = ['top tf', 'bottom tf']
  tf_id = tf_ids.first
  touch("textField marked:'#{tf_id}'")
  wait_for_keyboard

  is_ipad = ipad?
  is_iphone = iphone?
  is_ipod  = ipod?

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
      elsif is_iphone or is_ipod
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
        screenshot_and_raise 'not iphone, ipod, or ipad?!?'
      end
      #sample = ' ' if sample.eql?('`')
      rnd_str << sample
    end

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



And(/^one of the (input views|text fields|text views) has (?:a|an|the) (default|ascii|numbers and punctuation|url|number|phone|name and phone|email|decimal|twitter|web search) (?:keyboard|pad) showing$/) do |input_range, kb_type|
  if input_range == 'input views'
    qstr = qstr_for_random_text_input_view
  elsif input_range == 'text fields'
    qstr = qstr_for_random_text_field
  else
    qstr = qstr_for_random_text_view
  end

  target = _kb_type_with_step_arg kb_type
  ensure_keyboard_type(qstr, target)
  touch(qstr)
  wait_for_keyboard
end

Then(/^set my pin to "([^"]*)"$/) do |pin|
  ensure_text_input(pin, 'setting my pin')
end

When(/^I tap the delete key (\d+) times?, I should see "([^"]*)" in the text field$/) do |num_taps, result|
  before = text_from_first_responder()
  num = num_taps.to_i

  num.times {  keyboard_enter_char 'Delete' }

  idx = (before.length - num) - 1
  expected = before[0..idx]
  actual = text_from_first_responder()

  unless actual.eql?(expected)
    screenshot_and_raise "expected '#{expected}' after tapping the delete key '#{num}' times but found '#{actual}'"
  end
end

Then(/^I text my friend a facepalm "([^"]*)"$/) do |str|
  ensure_text_input str, 'texting'
end

And(/^realize my mistake and delete (\d+) characters? and replace with "([^"]*)"$/) do |num_taps, replacement|
  before = text_from_first_responder()
  num = num_taps.to_i

  num.times {
    keyboard_enter_char 'Delete'
  }

  idx = (before.length - num) - 1
  expected = "#{before[0..idx]}#{replacement}"

  keyboard_enter_text(replacement)

  actual = text_from_first_responder()

  unless actual.eql?(expected)
    screenshot_and_raise "expected '#{expected}' after tapping the delete key '#{num}' times but found '#{actual}'"
  end
end

Then(/^I type "([^"]*)"$/) do |str|
  ensure_text_input(str, 'typing', {:case_insensitive => true})
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


Then(/^I chose a text input view at random and type "([^"]*)"$/) do |str|
  qstr = qstr_for_random_text_input_view
  ensure_keyboard_type(qstr, :default)
  touch(qstr)
  wait_for_keyboard
  keyboard_enter_text str

  ensure_text_input str, 'typing'
end

Given(/^I choose a text input view at random$/) do
  @current_text_input_view = qstr_for_random_text_input_view
end

And(/^that text input view has (?:a|an|the) (default|ascii|numbers and punctuation|url|number|phone|name and phone|email|decimal|twitter|web search) (?:keyboard|pad)$/) do |kb_type|
  expect_current_text_input_view_set
  target = _kb_type_with_step_arg kb_type
  ensure_keyboard_type(@current_text_input_view, target)
end

And(/^all the text input view have the (default|ascii|numbers and punctuation|url|number|phone|name and phone|email|decimal|twitter|web search) (?:keyboard|pad)$/) do |kb_type|
  text_input_view_qstrs.each { |qstr|
    target = _kb_type_with_step_arg kb_type
    ensure_keyboard_type(qstr, target)
  }
end

And(/^I touch that text input view$/) do
  wait_for_query(@current_text_input_view)
  touch @current_text_input_view
end


And(/^the keyboard is showing$/) do
  wait_for_keyboard
end

And(/^the keyboard is docked$/) do
  ensure_docked_keyboard
end

Then(/^I should be able to touch the Return key$/) do
  expect_current_text_input_view_set

  clear_text(@current_text_input_view)
  touch(@current_text_input_view)
  wait_for_keyboard
  ensure_docked_keyboard
  keyboard_enter_char 'Return'

  expect_text = current_text_input_view_is_text_view? ? "\n" : ''

  res = query(@current_text_input_view, :text).first

  unless expect_text == res
    screenshot_and_raise "expected input view to have '#{expect_text}' but found '#{res}'"
  end

end


When(/^I type a key that does not exist it should raise an exception$/) do

  if xamarin_test_cloud?
    raise "Requires a fix that is not available yet.\nSee: https://github.com/calabash/calabash-ios/pull/605"
  else
    pending "Requires a fix that is not available yet.\nSee: https://github.com/calabash/calabash-ios/pull/605"
  end

  qstr = @current_text_input_view

  if text_field_qstrs.include?(qstr)

  elsif text_view_qstrs.include?(qstr)

  else
    raise "expected '#{qstr}' to be one of '#{text_input_view_qstrs}'"
  end

  str = 'str with ` backquote'
  e = nil
  begin
    keyboard_enter_text str
  rescue Exception => e
    # wrong
    # could not type 'str with ` backquote' - 'VerboseError: Unable to type: str with ` backquote'"
    # right
    # "could not type 'str with ` backquote' - 'VerboseError: target.frontMostApp().keyboard() failed to locate key '`''"
    exception_str = e.to_s
  ensure
    if e.nil?
      raise "expected 'failed to locate key' exception but none was raised"
    end
  end

end
