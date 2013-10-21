#!/bin/sh

bundle update
bundle install
rbenv rehash

# send a killall to instruments
# tried all manner of output redirects like:
#
# killall -9 instruments >/dev/null 2>&1`
#
# but instruments continued to spam the shell
#INSTRUMENTS_SPAM=`killall -9 instruments >/dev/null 2>&1`

IP=`cat ~/.xamarin/devices/venus/ip`
UDID=`cat ~/.xamarin/devices/venus/udid`
PLAYBACK_DIR="features/playback" \
CALABASH_FULL_CONSOLE_OUTPUT=0 \
DEBUG=1 \
DEVICE=ipad \
DEVICE_TARGET=${UDID} \
BUNDLE_ID="com.littlejoysoftware.Briar-cal" \
DEVICE_ENDPOINT=${IP} \
IRBRC=.irbrc \
bundle exec irb



