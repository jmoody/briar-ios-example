#!/bin/sh

XAMARIN_DIR="${PWD}/xamarin"

XAMARIN_DIR="${PWD}/xamarin"

if [ "$1" != "-" ]; then
  echo "INFO: creating the ./xamarin directory"
  if [ -d "${XAMARIN_DIR}" ]; then
    rm -rf "${XAMARIN_DIR}"
  fi
  mkdir -p "${XAMARIN_DIR}"
else
  echo "INFO: reusing the ./xamarin directory"
fi

echo "INFO: copying features over to ${XAMARIN_DIR}"
rm -rf "${XAMARIN_DIR}/features"
cp -r features "${XAMARIN_DIR}/"

echo "INFO: installing cucumber.yml to ${XAMARIN_DIR}"
cp "./config/xtc-profiles.yml" "${XAMARIN_DIR}/cucumber.yml"

echo "INFO: installing briar predefined steps to .xamarin/features"
echo "INFO:   - see briar/cucumber.rb for details"
BRIAR_INSTALL=`bundle show briar`
BRIAR_STEPS="${BRIAR_INSTALL}/features/step_definitions"
cp -r "${BRIAR_STEPS}" "${XAMARIN_DIR}/features/step_definitions/briar"

PRODUCT_NAME="Briar-cal"
SCHEME="Briar-cal"

if [ "$1" != "-" ]; then

  # this is stale comment, but useful to me (moody) so i will keep it around
  # use this strategy for dealing with 3rd party ipas that have been resigned with briar resign
  #SIGNING_IDENTITY="iPhone Distribution: Joshua Moody"
  #PROVISIONING_PROFILE="${HOME}/.xamarin/ios-resign/ljs/F4854C99-1BA3-44E2-954D-3B47D4083DDA.mobileprovision"
  #xcrun -sdk iphoneos PackageApplication -v "${APP}" -o "${IPA}" --sign "${SIGNING_IDENTITY}" --embed "${PROVISIONING_PROFILE}"

  echo "INFO: building the project"
  xcodebuild -scheme ${SCHEME} archive -configuration Debug -sdk iphoneos > /dev/null

  DATE=$( /bin/date +"%Y-%m-%d" )
  ARCHIVE=$( /bin/ls -t "${HOME}/Library/Developer/Xcode/Archives/${DATE}" | /usr/bin/grep xcarchive | /usr/bin/sed -n 1p )

  APP="${HOME}/Library/Developer/Xcode/Archives/${DATE}/${ARCHIVE}/Products/Applications/${PRODUCT_NAME}.app"
  IPA="${HOME}/tmp/${PRODUCT_NAME}.ipa"

  echo "INFO: packaging application"
  xcrun -sdk iphoneos PackageApplication -v "${APP}" -o "${IPA}" > /dev/null

  echo "INFO: copying ipa and app files"
  cp "${IPA}" "${XAMARIN_DIR}/"
  cp -r "${APP}" "${XAMARIN_DIR}/"
else
  echo "INFO: passed the '-' argument - will not rebuild the project"
fi
