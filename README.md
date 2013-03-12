briar-ios-example
=================

Xcode project to test and demonstrate the features of the briar gem: https://github.com/jmoody/briar

### testing locally on the simulator

1. launch/install the Briar-cal target on the simulator
2. ```cd briar-ios-example/Briar```
3. ```cucumber```

### testing on lesspainful

1. obtain an API Key from https://www.lesspainful.com
2. ```mkdir ~/.lesspainful```
3. echo "your-api-key" > ~/.lesspainful/briar
4. edit the ```briar-ios-example/Briar/lp-upload-example.sh``` and save as ```lp-upload.sh```
5. ```make lp```

this will build the
1. Briar-cal target
2. package and sign it
3. stage ipa and the feature files to ```briar-ios-example/Briar/lesspainful``` directory
4. ```lesspainful Briar-cal.ipa <api key>```







