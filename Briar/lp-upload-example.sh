#!/bin/bash
CC=
PRODUCT_NAME="Briar-cal"
SIGNING_IDENTITY="iPhone Distribution: Joshua Moody"
PROVISIONING_PROFILE="${HOME}/Library/MobileDevice/Provisioning Profiles/DA1697D1-E0EC-4C5A-8B39-5BDF1C68B65E.mobileprovision"

rm -rf lesspainful
mkdir lesspainful
cp -rf features lesspainful/
xcodebuild -scheme ${PRODUCT_NAME} archive -configuration Release -sdk iphoneos > /dev/null

DATE=$( /bin/date +"%Y-%m-%d" )
ARCHIVE=$( /bin/ls -t "${HOME}/Library/Developer/Xcode/Archives/${DATE}" | /usr/bin/grep xcarchive | /usr/bin/sed -n 1p )

APP="${HOME}/Library/Developer/Xcode/Archives/${DATE}/${ARCHIVE}/Products/Applications/${PRODUCT_NAME}.app"                                                                                                                          
IPA="${HOME}/tmp/${PRODUCT_NAME}.ipa"

xcrun -sdk iphoneos PackageApplication -v "${APP}" -o "${IPA}" --sign "${SIGNING_IDENTITY}" --embed "${PROVISIONING_PROFILE}"
cp "${IPA}" lesspainful/

cd lesspainful
echo "source 'https://rubygems.org'" > Gemfile
echo "gem 'briar', '0.0.6'" >> Gemfile
rm features/Rakefile
rm features/Gemfile
rm features/Gemfile.lock
lesspainful submit "${PRODUCT_NAME}.ipa" `cat ~/.lesspainful/briar`
