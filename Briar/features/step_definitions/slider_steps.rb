module Briar
  module Sliders

    def emotion_label_for_value(value)
      return     "sad: '#{-2}'" if value <  -1.5
      return "anxious: '#{-1}'" if value >= -1.5 and value < -0.5
      return   "bored: '#{0}'"  if value >= -0.5 and value <  0.5
      return    "calm: '#{1}'"  if value >=  0.5 and value <  1.5
               "happy: '#{2}'"
    end
  end
end


World(Briar::Sliders)

When(/^I change the "([^"]*)" slider to ([-+]?[0-9]*\.?[0-9]+), I should see the "([^"]*)" emoticon$/) do |slider_id, value, emoticon_id|
  _slider_id = "#{slider_id} slider"
  wait_for_view(_slider_id)
  target_val = value.to_f
    briar_slider_set_value _slider_id, target_val
  2.times { step_pause }
  base_str = "view:'BrSliderView' marked:'emotions' child"

  res = query("#{base_str} imageView marked:'#{emoticon_id}'").first
  if res.nil?
    screenshot_and_raise "expected to see image view with id '#{emoticon_id}'"
  end

  res = query("#{base_str} label marked:'title'", :text).first
  expected = emotion_label_for_value(target_val)
  unless res.eql?(expected)
    screenshot_and_raise "expected to see title '#{expected}' but found '#{res}'"
  end

  res = query("#{base_str} label marked:'value'", :text).first
  expected =  ('%.2f' % target_val)
  unless res.eql?(expected)
    screenshot_and_raise "expected to see value '#{expected}' but found '#{res}'"
  end
end

Then(/^I should see the emotions slider group at the top of the view$/) do
  wait_for_view('emotions')
end

Then(/^I should see the slider table$/) do
  wait_for_view('table')
end

Then(/^I observe that it is raining$/) do
  briar_slider_set_value 'weather slider', 1
  step_pause
end

Then(/^I decide we really need a paper airplane in the office$/) do
  briar_slider_set_value 'office slider', -1
  step_pause
end

Then(/^I note that used the telescope in my experiment$/) do
  briar_slider_set_value 'science slider', 2
  step_pause
end
