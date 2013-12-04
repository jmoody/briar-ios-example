#!/bin/sh

bundle update
bundle install
rbenv rehash

IP=`cat ~/.xamarin/devices/venus/ip`
UDID=`cat ~/.xamarin/devices/venus/udid`
PLAYBACK_DIR="features/playback" \
CALABASH_FULL_CONSOLE_OUTPUT=1 \
DEBUG=1 \
DEVICE=ipad \
DEVICE_TARGET=${UDID} \
BUNDLE_ID=com.littlejoysoftware.Briar-cal \
DEVICE_ENDPOINT=${IP} \
IRBRC=.irbrc \
bundle exec irb



