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

TMP_DEVICE="ipad"

if [ ! -z $1 ]; then
  TMP_DEVICE=$1
fi


IP=`cat ~/.lesspainful/devices/pluto/ip`
UDID=`cat ~/.lesspainful/devices/pluto/udid`
PLAYBACK_DIR="features/playback" \
CALABASH_FULL_CONSOLE_OUTPUT="1" \
DEVICE=$TMP_DEVICE \
OS="ios5" \
DEVICE_TARGET=${UDID} \
BUNDLE_ID="com.littlejoysoftware.Briar-cal" \
DEVICE_ENDPOINT=${IP} \
IRBRC=".irbrc" irb


