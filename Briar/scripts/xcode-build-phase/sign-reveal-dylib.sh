#!/usr/bin/env bash

# If you see an error like this:
#
# iPhone Developer: ambiguous (matches "iPhone Developer: Person A (2<snip>Q)"
#                                  and "iPhone Developer: Person B (8<snip>F)"
# in /Users/<snip>/Library/Keychains/login.keychain)
#
# Uncomment this line and update it with the correct credentials.
# CODE_SIGN_IDENTITY="iPhone Developer: Person B (8<snip>F)"
#
# Alternatively, define BRIAR_SIGNING_IDENTITY.

set -e

if [ -n "${BRIAR_SIGNING_IDENTITY}" ]; then
  echo "INFO: Briar signing identity is defined"
  CODE_SIGN_IDENTITY="${BRIAR_SIGNING_IDENTITY}"
  else
  echo "INFO: Briar signing identity is not defined"
fi

####################### BEGIN JENKINS KEYCHAIN #################################

if [ "${USER}" = "jenkins" ]; then
  echo "INFO: unlocking the keychain in sign-reveal-dylib.sh script."

  xcrun security unlock-keychain -p "${KEYCHAIN_PASSWORD}" "${KEYCHAIN_PATH}"
  xcrun security set-keychain-settings -t 3600 -l "${KEYCHAIN_PATH}"

  RETVAL=$?
  if [ ${RETVAL} != 0 ]; then
    echo "FAIL: could not unlock the keychain"
    exit ${RETVAL}
  fi
fi

####################### END JENKINS KEYCHAIN ####################################

if [ -n "${CODE_SIGN_IDENTITY}" ]; then
  REVEAL_DYLIB_PATH="${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}/libReveal.dylib"
  echo "code sign identity: ${CODE_SIGN_IDENTITY}"
  if [ "${USER}" = "jenkins" ]; then
    xcrun codesign -v --keychain ${KEYCHAIN_PATH} -fs ${CODE_SIGN_IDENTITY} "${REVEAL_DYLIB_PATH}"
  else
    xcrun codesign -v -fs "${CODE_SIGN_IDENTITY}" "${REVEAL_DYLIB_PATH}"
  fi
else
  echo "INFO: Skipping libReal.dylib codesigning because CODE_SIGN_IDENTITY=${CODE_SIGN_IDENTITY} is emtpy"
fi
