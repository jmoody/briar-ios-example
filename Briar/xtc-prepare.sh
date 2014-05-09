#!/usr/bin/env bash

XAMARIN_DIR="${PWD}/xtc-staging"


if [ "$1" = "-" ]; then
    echo "INFO: passed a '$1' so we will try to reuse the .ipa"
    echo "INFO: deleting the ./xtc-staging/features directory"
    rm -rf "${XAMARIN_DIR}/features"
else
    echo "INFO: creating the ./xtc-staging directory"
    rm -rf "${XAMARIN_DIR}"
    mkdir -p "${XAMARIN_DIR}"
fi

echo "INFO: copying features over to ${XAMARIN_DIR}"
cp -r features "${XAMARIN_DIR}/"

echo "INFO: installing cucumber.yml to ${XAMARIN_DIR}"
cp "./config/xtc-profiles.yml" "${XAMARIN_DIR}/cucumber.yml"

echo "INFO: installing briar predefined steps to .xamarin/features"
echo "INFO:   - see briar/cucumber.rb for details"
BRIAR_INSTALL=`bundle show briar`
BRIAR_STEPS="${BRIAR_INSTALL}/features/step_definitions"
cp -r "${BRIAR_STEPS}" "${XAMARIN_DIR}/features/step_definitions/briar"

if [ "$1" = "-" ]; then
    echo "INFO: will not rebuild the .ipa"
else
    WORKSPACE="../briar-ios-example.xcworkspace"
    SCHEME="Briar-cal"
    TARGET_NAME="Briar-cal"
    CONFIG="Debug"

    CAL_DISTRO_DIR="build/calabash"
    ARCHIVE_BUNDLE="${CAL_DISTRO_DIR}/briar-cal.xcarchive"
    APP_BUNDLE_PATH="${ARCHIVE_BUNDLE}/Products/Applications/Briar-cal.app"
    IPA_PATH="${CAL_DISTRO_DIR}/${TARGET_NAME}.ipa"

    rm -rf "${CAL_DISTRO_DIR}"
    mkdir -p "${CAL_DISTRO_DIR}"

    set +o errexit

    xcodebuild archive -workspace "${WORKSPACE}" -scheme "${SCHEME}" \
        -configuration "${CONFIG}" -archivePath "${ARCHIVE_BUNDLE}" \
        -sdk iphoneos | bundle exec xcpretty -c

    RETVAL=${PIPESTATUS[0]}

    set -o errexit

    if [ $RETVAL != 0 ]; then
        echo "FAIL:  archive failed"
        exit $RETVAL
    fi

    set +o errexit

    xcrun -sdk iphoneos PackageApplication -v "${PWD}/${APP_BUNDLE_PATH}" -o "${PWD}/${IPA_PATH}" > /dev/null

    RETVAL=$?

    set -o errexit

    if [ $RETVAL != 0 ]; then
        echo "FAIL:  export archive failed"
        exit $RETVAL
    fi

    cp "${IPA_PATH}" "${XAMARIN_DIR}/"
fi
