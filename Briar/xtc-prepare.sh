#!/usr/bin/env bash

XCPRETTY=`gem list xcpretty -i`
if [ "${XCPRETTY}" = "false" ]; then gem install xcpretty; fi

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

if [ "$1" = "-" ]; then
    echo "INFO: will not rebuild the .ipa"
else

    ####################### JENKINS KEYCHAIN #######################################

    echo "INFO: unlocking the keychain 1 of 2 in xtc-prepare.sh"

    # unlock the keychain - WARNING: might need to run 1x in UI to 'allow always'
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
    fi

    WORKSPACE="../briar-ios-example.xcworkspace"
    SCHEME="Briar-cal"
    TARGET_NAME="Briar-cal"
    CONFIG="Debug"

    CAL_DISTRO_DIR="build/ipa"
    ARCHIVE_BUNDLE="${CAL_DISTRO_DIR}/briar-cal.xcarchive"
    APP_BUNDLE_PATH="${ARCHIVE_BUNDLE}/Products/Applications/Briar-cal.app"
    IPA_PATH="${CAL_DISTRO_DIR}/${TARGET_NAME}.ipa"

    rm -rf "${CAL_DISTRO_DIR}"
    mkdir -p "${CAL_DISTRO_DIR}"

    set +o errexit


   if [ -z "${BRIAR_SIGNING_IDENTITY}" ]; then
    xcrun xcodebuild archive \
        OTHER_CODE_SIGN_FLAGS=${OTHER_CODE_SIGN_FLAGS} \
        -SYMROOT="${CAL_DISTRO_DIR}" \
        -derivedDataPath "${CAL_DISTRO_DIR}" \
        -workspace "${WORKSPACE}" \
        -scheme "${SCHEME}" \
        -configuration "${CONFIG}" \
        -archivePath "${ARCHIVE_BUNDLE}" \
        -sdk iphoneos #| xcpretty -c
   else
        xcrun xcodebuild archive \
        OTHER_CODE_SIGN_FLAGS=${OTHER_CODE_SIGN_FLAGS} \
        CODE_SIGN_IDENTITY="${BRIAR_SIGNING_IDENTITY}" \
        -SYMROOT="${CAL_DISTRO_DIR}" \
        -derivedDataPath "${CAL_DISTRO_DIR}" \
        -workspace "${WORKSPACE}" \
        -scheme "${SCHEME}" \
        -configuration "${CONFIG}" \
        -archivePath "${ARCHIVE_BUNDLE}" \
        -sdk iphoneos #| xcpretty -c
   fi


    #RETVAL=${PIPESTATUS[0]}
    RETVAL=$?

    set -o errexit

    if [ $RETVAL != 0 ]; then
        echo "FAIL:  archive failed"
        exit $RETVAL
    fi

    set +o errexit

    ####################### JENKINS KEYCHAIN #######################################

    echo "INFO: unlocking the keychain 2 of 2 in xtc-prepare.sh"

    # unlock the keychain - WARNING: might need to run 1x in UI to 'allow always'
    if [ "${USER}" = "jenkins" ]; then
        xcrun security unlock-keychain -p "${KEYCHAIN_PASSWORD}" "${KEYCHAIN_PATH}"
        RETVAL=$?
        if [ ${RETVAL} != 0 ]; then
            echo "FAIL: could not unlock the keychain"
            exit ${RETVAL}
        fi
        xcrun security set-keychain-settings -t 3600 -l "${KEYCHAIN_PATH}"
    fi

    xcrun -sdk iphoneos PackageApplication --verbose \
        -v "${PWD}/${APP_BUNDLE_PATH}" \
        -o "${PWD}/${IPA_PATH}"

    set -o errexit

    if [ $RETVAL != 0 ]; then
       echo "FAIL:  export archive failed"
       exit $RETVAL
    fi

    cp "${IPA_PATH}" "${XAMARIN_DIR}/"
fi
