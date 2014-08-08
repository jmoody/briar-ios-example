require 'calabash-cucumber/cucumber'
ENV['NO_BRIAR_PREDEFINED_STEPS'] = '1'
require 'briar/cucumber'
require 'faker'

# skip pry on the test cloud
if ENV['XAMARIN_TEST_CLOUD'] != '1'
  require 'pry'
end

I18n.enforce_available_locales = false

# override cucumber pending on the XTC
if ENV['XAMARIN_TEST_CLOUD'] == '1'
  module Cucumber
    module RbSupport
      def pending(message = 'TODO')
        raise "PENDING: #{message}"
      end
    end
  end
  World(Cucumber::RbSupport)
end
