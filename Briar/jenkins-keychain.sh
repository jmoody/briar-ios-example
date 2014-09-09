#!/usr/bin/env bash

####################### JENKINS KEYCHAIN #######################################
echo "INFO: unlocking the keychain"
if [ "${USER}" = "jenkins" ]; then
    xcrun security default-keychain -d user -s "${JENKINS_KEYCHAIN}"
    RETVAL=$?
    if [ ${RETVAL} != 0 ]; then
        echo "FAIL: could not set the default keychain"
        exit ${RETVAL}
    fi
fi

# unlock the keychain - WARNING: might need to run 1x in UI to 'allow always'
if [ "${USER}" = "jenkins" ]; then
    xcrun security unlock-keychain -p "${JENKINS_KEYCHAIN_PASS}" "${JENKINS_KEYCHAIN}"
    RETVAL=$?
    if [ ${RETVAL} != 0 ]; then
        echo "FAIL: could not unlock the keychain"
        exit ${RETVAL}
    fi
fi

exit 0
