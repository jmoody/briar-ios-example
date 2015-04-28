#!/usr/bin/env bash

if which rbenv > /dev/null; then
    RBENV_EXEC="rbenv exec"
else
    RBENV_EXEC=
fi

${RBENV_EXEC} bundle install


TARGET_NAME="Briar-cal"
XC_WORKSPACE="../briar-ios-example.xcworkspace"
XC_SCHEME="${TARGET_NAME}"
CAL_BUILD_CONFIG=Debug
CAL_BUILD_DIR="${PWD}/build/jenkins"

rm -rf "${TARGET_NAME}.app"
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

if [ ${RETVAL} != 0 ]; then
    echo "FAIL:  could not build"
    exit ${RETVAL}
else
    echo "INFO: successfully built"
fi

# remove any stale targets
rbenv exec bundle exec calabash-ios sim reset

cp -r "${CAL_BUILD_DIR}/Build/Products/${CAL_BUILD_CONFIG}-iphonesimulator/${TARGET_NAME}.app" ./

echo "export APP=${PWD}/${TARGET_NAME}.app"

