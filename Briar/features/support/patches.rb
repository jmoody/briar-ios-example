require 'calabash-cucumber'

if Calabash::Cucumber::Core.instance_methods.include?(:slider_set_value)
  puts "\033[35mINFO: Calabash::Cucumber::Core :slider_set_value patch can be removed.\033[0m"
else
  puts "\033[35mINFO: patching Calabash::Cucumber::Core with :slider_set_value\033[0m"
  module Calabash
    module Cucumber
      module Core
        def slider_set_value(uiquery, value,  options={})
          default_options =  {:animate => true,
                              :notify_targets => true}
          merged_options = default_options.merge(options)

          value_str = value.to_s

          args = [merged_options[:animate], merged_options[:notify_targets]]
          views_touched = map(uiquery, :changeSlider, value_str, *args)

          msg = "Could not set value of slider to '#{value}' using query '#{uiquery}'"
          assert_map_results(views_touched, msg)
          views_touched
        end
      end
    end
  end
end
