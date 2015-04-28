#!/usr/bin/env bash

XCPRETTY=`gem list xcpretty -i`
if [ "${XCPRETTY}" = "false" ]; then gem install xcpretty; fi

CUCUMBER_ARGS=$*

rbenv exec bundle install

rm -rf ci-reports/calabash
mkdir -p ci-reports/calabash
touch ci-reports/calabash/empty.json

TARGET_NAME="Briar-cal"
XC_WORKSPACE="../briar-ios-example.xcworkspace"
XC_SCHEME="${TARGET_NAME}"
CAL_BUILD_CONFIG=Debug
CAL_BUILD_DIR="${PWD}/build/jenkins"
rm -rf "${CAL_BUILD_DIR}"
mkdir -p "${CAL_BUILD_DIR}"

####################### JENKINS KEYCHAIN #######################################

echo "INFO: unlocking the keychain"

if [ "${USER}" = "jenkins" ]; then
    xcrun security unlock-keychain -p "${KEYCHAIN_PASSWORD}" "${KEYCHAIN_PATH}"
    RETVAL=$?
    if [ ${RETVAL} != 0 ]; then
        echo "FAIL: could not unlock the keychain"
        exit ${RETVAL}
    fi

    xcrun security set-keychain-settings -t 3600 -l "${KEYCHAIN_PATH}"
    OTHER_CODE_SIGN_FLAGS="--keychain=${KEYCHAIN_PATH}"
    xcrun security show-keychain-info ${KEYCHAIN_PATH}
    xcrun security -v list-keychains -d user
fi

# build the -cal target to get it on the phone
set +o errexit

xcrun xcodebuild \
    OTHER_CODE_SIGN_FLAGS=${OTHER_CODE_SIGN_FLAGS} \
    -SYMROOT="${CAL_BUILD_DIR}" \
    -derivedDataPath "${CAL_BUILD_DIR}" \
    -workspace "${XC_WORKSPACE}" \
    -scheme "${TARGET_NAME}" \
    -sdk iphonesimulator \
    -configuration "${CAL_BUILD_CONFIG}" \
    clean build | xcpretty -c

RETVAL=${PIPESTATUS[0]}

set -o errexit

if [ ${RETVAL} != 0 ]; then
    echo "FAIL:  could not build"
    exit ${RETVAL}
else
    echo "INFO: successfully built"
fi

# remove any stale targets
rbenv exec bundle exec calabash-ios sim reset

# Disable exiting on error so script continues if tests fail
set +o errexit

export APP_BUNDLE_PATH="${CAL_BUILD_DIR}/Build/Products/${CAL_BUILD_CONFIG}-iphonesimulator/${TARGET_NAME}.app"

rbenv exec bundle exec cucumber -p default       -f json -o ci-reports/calabash/iphone5.json -f junit -o ci-reports/calabash/junit ${CUCUMBER_ARGS}

set -o errexit

# always exit zero - let the cucumber post build script handle reporting
# success or failure based on the cucumber output.
exit 0
