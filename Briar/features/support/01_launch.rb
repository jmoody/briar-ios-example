require 'calabash-cucumber/launcher'


# noinspection ALL
module LaunchControl
  @@launcher = nil

  def self.launcher
    @@launcher ||= Calabash::Cucumber::Launcher.new
  end

  def self.launcher=(launcher)
    @@launcher = launcher
  end
end


#noinspection RubyUnusedLocalVariable
Before do |scenario|

  launch_options = {
        :uia_strategy => :shared_element
  }

  LaunchControl.launcher.relaunch(launch_options)
  LaunchControl.launcher.calabash_notify(self)

  # I have tried launching 1x, but the results are not good on the simulators.
  # backdoor('calabash_backdoor_reset_app:', 'ignorable')

  req_elms = ['tabBar',
              "navigationItemView marked:'Buttons'"]
  msg = 'timed out waiting for backdoor reset'
  wait_for_elements_exist(req_elms,
                          {:timeout => 10.0,
                           :retry_frequency => 0.4,
                           :timeout_message => msg,
                           :post_timeout => 0.4})

  @cp = nil
  @model = briar_model()
end

#noinspection RubyUnusedLocalVariable
After do |scenario|
  launcher = LaunchControl.launcher
  unless launcher.calabash_no_stop?
    calabash_exit
    launcher.stop
  end
end

at_exit do
  launcher = LaunchControl.launcher
  launcher.stop unless launcher.calabash_no_stop?
end
