Given(/^that the keychain is clear$/) do
  keychain_clear_accounts_for_service('briar-ios-example.service')
end

Then(/^the keychain should contain the account password "(.*?)" for "(.*?)"$/) do |password, username|
  actual = keychain_password('briar-ios-example.service', username)
  unless actual == password
    screenshot_and_raise "expected '#{password}' in keychain but found '#{actual}'"
  end
end

Given(/^that the keychain contains the account password "(.*?)" for "(.*?)"$/) do |password, username|
  # app uses the first account/password pair it finds, so clear out
  # any preexisting saved passwords for our service
  keychain_clear_accounts_for_service('briar-ios-example.service')
  keychain_set_password('briar-ios-example.service', username, password)
end
