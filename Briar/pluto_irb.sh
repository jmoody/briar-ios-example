#!/bin/sh
IP=`cat ~/.lesspainful/devices/pluto/ip`
UDID=`cat ~/.lesspainful/devices/pluto/udid`
PLAYBACK_DIR="features/playback" \
CALABASH_FULL_CONSOLE_OUTPUT="1" \
DEVICE="ipad" \
OS="ios5" \
DEVICE_TARGET=${UDID} \
BUNDLE_ID="build/Briar" \
DEVICE_ENDPOINT=${IP} \
IRBRC=".irbrc" irb


