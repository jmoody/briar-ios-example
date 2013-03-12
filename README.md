briar-ios-example
=================

Xcode project to test and demonstrate the features of the briar gem: https://github.com/jmoody/briar

briar extends the predefined calabash-cucumber steps.

### motivation

DRY: i have several ios projects that use calabash-cucumber and i found i was rewritting lots
of steps and supporting code.

TEST: i want to prova while back, i tried to port the calabash-ios-server to ARC to fix a leak that was causing
one of my tests to occassionally crash.  i did my conversion and realized there was no way to see
if my fixes broke calabash (other than running my own tests locally). 

2. provide an iOS app that the calabash-ios community can use to test the calabash framework

### testing locally on the simulator

1. ```cd briar-ios-example/Briar/features```
2. ```bundle update && bundle install```
3. launch/install the Briar-cal target on the simulator
4. ```cd briar-ios-example/Briar```
5. ```cucumber```

### testing on lesspainful

1. obtain an API Key from https://www.lesspainful.com
2. ```mkdir ~/.lesspainful```
3. echo "your-api-key" > ~/.lesspainful/briar
4. edit the ```briar-ios-example/Briar/lp-upload-example.sh``` and save as ```lp-upload.sh```
5. ```make lp```

the make command will do the following:

1. build Briar-cal target
2. package and sign it (
3. stage ipa and the feature files to ```briar-ios-example/Briar/lesspainful``` directory
4. ```lesspainful Briar-cal.ipa <api key>```








