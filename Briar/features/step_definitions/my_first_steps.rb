Given /^I am on the Welcome Screen$/ do
  tabbar_visible?
  element_exists("view")
  sleep(STEP_PAUSE)
end

