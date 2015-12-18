all:
	$(MAKE) ipa
	$(MAKE) ipa-cal
	$(MAKE) app
	$(MAKE) app-cal

clean:
	rm -rf build
	rm -rf Products
	rm -rf xtc-submit-*

  # Legacy
	rm -rf Briar*.ipa
	rm -rf Briar*.app.dSYM
	rm -rf Briar*.app
	rm -rf xtc-staging

# Builds an ipa with no Calabash server.
#
# This ipa is suitable for testing dylib injection on physical
# devices.
#
# Dylib injection is not supported for ipas yet and is not
# supported on the Xamarin Test Cloud.
ipa:
	bin/make/ipa.sh

# Builds an app with no Calabash server.
#
# This app is suitable for testing dylib injection on iOS Simulators.
app:
	bin/make/app.sh

# Builds an ipa from the CalSmoke-cal target.
#
# This ipa links the calabash.framework at during the build.
#
# This kind of build is suitable for the Xamarin Test Cloud.
ipa-cal:
	bin/make/ipa-cal.sh

# Builds an app from the CalSmoke-cal target.
#
# This app links the calabash.framework during the build.
app-cal:
	bin/make/app-cal.sh

