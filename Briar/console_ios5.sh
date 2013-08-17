#!/bin/bash
TMP_DEVICE="iphone"

if [ ! -z $1 ]; then
  TMP_DEVICE=$1
fi
DEVICE=$TMP_DEVICE \
PLAYBACK_DIR=./features/playback \
DEVICE_TARGET=simulator \
OS=ios5 \
IRBRC=.irbrc irb
