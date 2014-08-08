########################################
#                                      #
#       Important Note                 #
#                                      #
#   When running calabash-ios tests at #
#   www.xamarin.com/test-cloud         #
#   the  methods invoked by            #
#   CalabashLauncher are overriden.    #
#   It will automatically ensure       #
#   running on device, installing apps #
#   etc.                               #
#                                      #
########################################

require 'calabash-cucumber/launcher'


# APP_BUNDLE_PATH = "~/Library/Developer/Xcode/DerivedData/??/Build/Products/Calabash-iphonesimulator/??.app"
# You may uncomment the above to overwrite the APP_BUNDLE_PATH
# However the recommended approach is to let Calabash find the app itself
# or set the environment variable APP_BUNDLE_PATH


#noinspection RubyUnusedLocalVariable
Before do |scenario|

  # if defined?(MY_LAUNCHER)
  #   # @calabash_launcher is a Cucumber World variable
  #   # World variables are set to 'nil' before each Scenario
  #   # - assign @calabash_launcher to MY_LAUNCHER
  #   @calabash_launcher = MY_LAUNCHER
  # else
  #   # defines a constant that will persist over Scenarios
  #   MY_LAUNCHER = Calabash::Cucumber::Launcher.new
  #   # assign the @calabash_launcher World variable to the constant
  #   @calabash_launcher = MY_LAUNCHER
  #
  #   # relaunch!
  #   @calabash_launcher.relaunch()
  #   @calabash_launcher.calabash_notify(self)
  # end

  @calabash_launcher = Calabash::Cucumber::Launcher.new
  unless @calabash_launcher.calabash_no_launch?
    @calabash_launcher.relaunch
    @calabash_launcher.calabash_notify(self)
  end

  backdoor('calabash_backdoor_reset_app:', 'ignorable')
  req_elms = ['tabBar',
              "navigationItemView marked:'Buttons'"]

  msg = 'timed out waiting for backdoor reset'
  wait_for_elements_exist(req_elms,
                          {:timeout => 4.0,
                           :retry_frequency => 0.4,
                           :timeout_message => msg})
  sleep(0.4)

  @cp = nil
  @model = briar_model()
end

#noinspection RubyUnusedLocalVariable
After do |scenario|
  unless @calabash_launcher.calabash_no_stop?
    calabash_exit
    if @calabash_launcher.active?
      @calabash_launcher.stop
    end
  end
end

at_exit do
  launcher = Calabash::Cucumber::Launcher.new
  if launcher and launcher.simulator_target? and (not launcher.calabash_no_stop?)
    launcher.stop
  end
end
