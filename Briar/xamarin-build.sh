#!/bin/sh

PRODUCT_NAME="Briar-cal"
SCHEME="Briar-cal"

echo "INFO: xcodebuild"
xcodebuild -scheme ${SCHEME} archive -configuration Release -sdk iphoneos > /dev/null

DATE=$( /bin/date +"%Y-%m-%d" )
ARCHIVE=$( /bin/ls -t "${HOME}/Library/Developer/Xcode/Archives/${DATE}" | /usr/bin/grep xcarchive | /usr/bin/sed -n 1p )

APP="${HOME}/Library/Developer/Xcode/Archives/${DATE}/${ARCHIVE}/Products/Applications/${PRODUCT_NAME}.app"
IPA="${HOME}/tmp/${PRODUCT_NAME}.ipa"


echo "INFO: xcrun PackageApplication"


# use this strategy for dealing with 3rd party ipas that have been resigned
# with briar resign
#SIGNING_IDENTITY="iPhone Distribution: Joshua Moody"
#PROVISIONING_PROFILE="${HOME}/.xamarin/ios-resign/ljs/F4854C99-1BA3-44E2-954D-3B47D4083DDA.mobileprovision"
#xcrun -sdk iphoneos PackageApplication -v "${APP}" -o "${IPA}" --sign "${SIGNING_IDENTITY}" --embed "${PROVISIONING_PROFILE}"

# use this strategy for Briar-cal
xcrun -sdk iphoneos PackageApplication -v "${APP}" -o "${IPA}" > /dev/null

echo "INFO: copying files"
cp "${IPA}" ./xamarin/
cp -r "${APP}" ./xamarin/
cp cucumber.yml ./xamarin/

echo "source 'https://rubygems.org'" > ./xamarin/Gemfile
echo "gem 'briar', '0.1.3'" >> ./xamarin/Gemfile

echo "INFO: cleaning up"

rm -rf ./xamarin/features/Gemfile
rm -rf ./xamarin/features/Gemfile.lock
rm -rf ./xamarin/features/Rakefile
rm -rf ./xamarin/features/.bundle
rm -rf ./xamarin/features/.idea


