#!/bin/sh

bundle install
bundle update

# send a killall to instruments
# tried all manner of output redirects like:
#
# killall -9 instruments >/dev/null 2>&1`
#
# but instruments continued to spam the shell
#INSTRUMENTS_SPAM=`killall -9 instruments >/dev/null 2>&1`

TMP_DEVICE="ipad"

if [ ! -z $1 ]; then
  TMP_DEVICE=$1
fi


IP=`cat ~/.xamarin/devices/pluto/ip`
UDID=`cat ~/.xamarin/devices/pluto/udid`
PLAYBACK_DIR="features/playback" \
CALABASH_FULL_CONSOLE_OUTPUT="1" \
DEBUG=1 \
DEVICE=$TMP_DEVICE \
DEVICE_TARGET=${UDID} \
BUNDLE_ID="com.littlejoysoftware.Briar-cal" \
DEVICE_ENDPOINT=${IP} \
IRBRC=.irbrc \
bundle exec irb


