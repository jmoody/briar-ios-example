#!/bin/sh
#!/bin/sh

PRODUCT_NAME="Briar-cal"
SCHEME="Briar-cal"
SIGNING_IDENTITY="iPhone Distribution: Joshua Moody"
PROVISIONING_PROFILE="~/.xamarin/ios-resign/ljs/F4854C99-1BA3-44E2-954D-3B47D4083DDA.mobileprovision"

echo "INFO: xcodebuild"
xcodebuild -scheme ${SCHEME} archive -configuration Release -sdk iphoneos > /dev/null

DATE=$( /bin/date +"%Y-%m-%d" )
ARCHIVE=$( /bin/ls -t "${HOME}/Library/Developer/Xcode/Archives/${DATE}" | /usr/bin/grep xcarchive | /usr/bin/sed -n 1p )

APP="${HOME}/Library/Developer/Xcode/Archives/${DATE}/${ARCHIVE}/Products/Applications/${PRODUCT_NAME}.app"
IPA="${HOME}/tmp/${PRODUCT_NAME}.ipa"


echo "INFO: xcrun PackageApplication"
xcrun -sdk iphoneos PackageApplication -v "${APP}" -o "${IPA}" --sign "${SIGNING_IDENTITY}" --embed "${PROVISIONING_PROFILE}"
#xcrun -sdk iphoneos PackageApplication -v "${APP}" -o "${IPA}" > /dev/null


echo "INFO: copying files"
cp "${IPA}" ./xamarin/
cp -r "${APP}" ./xamarin/
cp cucumber.yml ./xamarin/

cd xamarin
echo "source 'https://rubygems.org'" > Gemfile
echo "gem 'briar', '0.1.3'" >> Gemfile

echo "INFO: cleaning up"

rm -rf features/Gemfile
rm -rf features/Gemfile.lock
rm -rf features/Rakefile
rm -rf features/.bundle
rm -rf features/.idea



  
