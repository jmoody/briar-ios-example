#!/bin/sh

bundle update && bundle install

#DEV_DIR=`xcode-select --print-path | tr -d '\n'`
#IOS_SIM="${DEV_DIR}/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone Simulator.app"
#open -a "${IOS_SIM}"
#open -a "Terminal"


# send a killall to instruments
# tried all manner of output redirects like:
#
# killall -9 instruments >/dev/null 2>&1`
#
# but instruments continued to spam the shell
#INSTRUMENTS_SPAM=`killall -9 instruments >/dev/null 2>&1`

TMP_DEVICE="iphone"

if [ ! -z $1 ]; then
  TMP_DEVICE=$1
fi

PLAYBACK_DIR="features/playback" \
DEVICE=$TMP_DEVICE \
SDK_VERSION=6.1 \
CALABASH_FULL_CONSOLE_OUTPUT=1 \
RESET_BETWEEN_SCENARIOS=1 \
DEVICE_TARGET=simulator \
IRBRC=.irbrc \
bundle exec irb
