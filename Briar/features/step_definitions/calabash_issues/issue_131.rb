When(/^I add a security veil to the main window$/) do
  res = backdoor('calabash_backdoor_add_security_veil_to_main_window:', 'ignorable')
  unless res == 'YES'
    screenshot_and_raise "expected to be able to use the backdoor to add a security veil to the main window but found '#{res}'"
  end
  veil = 'security veil'
  wait_for_view veil
  # ipad requires a longer wait
  4.times { step_pause }
end

Then(/^I dismiss the security veil$/) do
  step_pause
  touch_and_wait_to_disappear 'security veil'
end


Then(/^I should not be able to see navigation bar because of the security veil$/) do
  views = ['navigationBar']
  timeout = 2.0
  msg = "waited for '#{timeout}' seconds for 'navigation bar' to disappear but it is still visible"
  wait_for_elements_do_not_exist(views, {:timeout => timeout,
                                         :retry_frequency => 0.2,
                                         :post_timeout => 0.1,
                                         :timeout_message => msg})
end

Then(/^I should not be able to see tab bar because of the security veil$/) do
  views = ['tabBar']
  timeout = 2.0
  msg = "waited for '#{timeout}' seconds for 'tab bar' to disappear but it is still visible"
  wait_for_elements_do_not_exist(views, {:timeout => timeout,
                                         :retry_frequency => 0.2,
                                         :post_timeout => 0.1,
                                         :timeout_message => msg})
end


Then(/^I should not be able to see the elements on the topmost view$/) do
  views = ['show modal', 'email', 'show sheet', 'first']
  timeout = 2.0

  elements = views.map { |view_id| "view marked:'#{view_id}'"}
  msg = "waited for '#{timeout}' seconds for '#{views}' to disappear but some of them are still visible"
  wait_for_elements_do_not_exist(elements, {:timeout => timeout,
                                         :retry_frequency => 0.2,
                                         :post_timeout => 0.1,
                                         :timeout_message => msg})
end
