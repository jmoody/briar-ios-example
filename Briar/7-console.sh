#!/bin/bash

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

TMP_DEVICE="iphone"

if [ ! -z $1 ]; then
  TMP_DEVICE=$1
fi
DEVICE=$TMP_DEVICE \
CALABASH_FULL_CONSOLE_OUTPUT=1 \
DEVICE_TARGET=simulator \
OS=ios7 \
IRBRC=.irbrc irb
