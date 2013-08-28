#!/bin/sh

briar install-calabash-gem
briar gem
rbenv rehash

# send a killall to instruments
# tried all manner of output redirects like:
#
# killall -9 instruments >/dev/null 2>&1`
#
# but instruments continued to spam the shell
INSTRUMENTS_SPAM=`killall -9 instruments >/dev/null 2>&1`

IP=`cat ~/.lesspainful/devices/neptune/ip`
UDID=`cat ~/.lesspainful/devices/neptune/udid`
PLAYBACK_DIR="features/playback" \
CALABASH_FULL_CONSOLE_OUTPUT="1" \
DEVICE="iphone" \
OS="ios6" \
DEVICE_TARGET=${UDID} \
BUNDLE_ID="com.littlejoysoftware.Briar-cal" \
DEVICE_ENDPOINT=${IP} \
IRBRC=".irbrc" irb


