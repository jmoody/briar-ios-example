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
  should_see_image_view emoticon_id
  should_see_label_with_text 'title', emotion_label_for_value(target_val)
  should_see_label_with_text 'value', ('%.2f' % target_val)
end

Then(/^I should see the emotions slider group at the top of the view$/) do
  wait_for_view('emotions')
end

Then(/^I should see the slider table$/) do
  wait_for_view('sliders table')
  wait_for_view('a list of sliders')
end
