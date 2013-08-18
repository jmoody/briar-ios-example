#!/bin/bash
TMP_DEVICE="iphone"

if [ ! -z $1 ]; then
  TMP_DEVICE=$1
fi
DEVICE=$TMP_DEVICE \
CALABASH_FULL_CONSOLE_OUTPUT=1 \
DEVICE_TARGET=simulator \
OS=ios7 \
IRBRC=.irbrc irb
