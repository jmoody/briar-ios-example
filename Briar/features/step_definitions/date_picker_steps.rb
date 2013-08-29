
Then(/^I should not see any of the show picker buttons$/) do
  arr = ["show date and time picker","show date picker", 'show time picker']
  arr.each { |view_id|
    should_not_see_button view_id
  }
end
