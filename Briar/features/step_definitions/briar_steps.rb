require 'briar/briar_steps'

Then(/^I should not see the tab bar if I am on the iphone or if ipad is orientated left or right$/) do
  stats = orientation_stats
  device_o = stats[:device]
  if ipad? && (device_o.eql?('left') || device_o.eql?('right'))
    should_see_tabbar
  else
    should_not_see_tabbar
  end
end

Then(/^I wait for rotation animation$/) do
  2.times { step_pause }
end

