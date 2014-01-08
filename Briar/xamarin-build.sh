#!/bin/sh

PWD=`pwd`
XAMARIN_DIR="${PWD}/xamarin"

if [ -d "${XAMARIN_DIR}" ]; then
  rm -rf "${XAMARIN_DIR}"
fi

mkdir -p "${XAMARIN_DIR}"

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
cp "${IPA}" "${XAMARIN_DIR}/"
cp -r "${APP}" "${XAMARIN_DIR}/"
cp -r features "${XAMARIN_DIR}/"

echo "INFO: cleaning up"
rm -rf "${XAMARIN_DIR}/features/Gemfile"
rm -rf "${XAMARIN_DIR}/features/Gemfile.lock"
rm -rf "${XAMARIN_DIR}/features/Rakefile"
rm -rf "${XAMARIN_DIR}/features/.bundle"
rm -rf "${XAMARIN_DIR}/features/.idea"

mv "${XAMARIN_DIR}/features/xtc_gemfile" "${XAMARIN_DIR}/Gemfile"
mv "${XAMARIN_DIR}/features/xtc_profiles.yml" "${XAMARIN_DIR}/cucumber.yml"



