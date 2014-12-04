Given(/^that the keychain is clear$/) do
  keychain_clear_accounts_for_service('briar-ios-example.service')
end

Then(/^the keychain should contain the account password "(.*?)" for "(.*?)"$/) do |password, username|
  if xamarin_test_cloud?
    if ios8?
      # JSON::ParserError - A JSON text must at least contain two octets! (JSON::ParserError)
      # /calabash-cucumber/keychain_helpers.rb:33:in `_keychain_get'
      # Not working on the XTC w/ iOS 8
    else
      # password is not available on the Xamarin Test Cloud, but is available
      # on simulators and local devices.
      keychain_details = _keychain_get.first
      expected = { 'svce' => 'briar-ios-example.service',
                   'acct' => 'username' }
      expected.each_pair do |key, value|
        unless keychain_details[key] == value
          raise "expected '#{key}' => '#{value}' in #{keychain_details}"
        end
      end
    end
  else
    actual = keychain_password('briar-ios-example.service', username)
    unless actual == password
      screenshot_and_raise "expected '#{password}' in keychain but found '#{actual}'"
    end
  end
end

Given(/^that the keychain contains the account password "(.*?)" for "(.*?)"$/) do |password, username|
  # app uses the first account/password pair it finds, so clear out
  # any preexisting saved passwords for our service
  keychain_clear_accounts_for_service('briar-ios-example.service')
  keychain_set_password('briar-ios-example.service', username, password)
end
