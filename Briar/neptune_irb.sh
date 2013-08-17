#!/bin/sh
IP=`cat ~/.lesspainful/devices/neptune/ip`
UDID=`cat ~/.lesspainful/devices/neptune/udid`
PLAYBACK_DIR="features/playback" \
CALABASH_FULL_CONSOLE_OUTPUT="1" \
DEVICE="iphone" \
OS="ios6" \
DEVICE_TARGET=${UDID} \
BUNDLE_ID="build/Briar" \
DEVICE_ENDPOINT=${IP} \
IRBRC=".irbrc" irb


