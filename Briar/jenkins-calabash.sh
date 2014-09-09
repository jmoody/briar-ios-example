#!/usr/bin/env bash

XCPRETTY=`gem list xcpretty -i`
if [ "${XCPRETTY}" = "false" ]; then gem install xcpretty; fi

TAGS=$*

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
./jenkins-keychain.sh

# build the -cal target to get it on the phone
set +o errexit

xcrun xcodebuild \
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

export APP="${CAL_BUILD_DIR}/Build/Products/${CAL_BUILD_CONFIG}-iphonesimulator/${TARGET_NAME}.app"
echo "APP = ${APP}"

rbenv exec bundle exec cucumber -p sim71_4in         -f json -o ci-reports/calabash/iphone5.json -f junit -o ci-reports/calabash/junit ${TAGS}

# exhaustive testing is pointless - that is what the XTC is for
#rbenv exec bundle exec cucumber -p sim61_4in         -f json -o ci-reports/calabash/iphone-61-4in.json ${TAGS}
#rbenv exec bundle exec cucumber -p sim61_sl          -f json -o ci-reports/calabash/iphone-61-no-instruments.json ${TAGS}
#rbenv exec bundle exec cucumber -p sim71_64b         -f json -o ci-reports/calabash/iphone-71-4in-64b.json $TAGS
#rbenv exec bundle exec cucumber -p sim61r            -f json -o ci-reports/calabash/iphone-61-3.5in.json $TAGS
#rbenv exec bundle exec cucumber -p sim71r            -f json -o ci-reports/calabash/iphone-71-3.5in.json $TAGS

#rbenv exec bundle exec cucumber -p sim61_ipad_r      -f json -o ci-reports/calabash/ipad-61.json $TAGS
#rbenv exec bundle exec cucumber -p sim71_ipad_r      -f json -o ci-reports/calabash/ipad-71.json $TAGS
#rbenv exec bundle exec cucumber -p sim71_ipad_r_64b  -f json -o ci-reports/calabash/ipad-71-64b.json $TAGS

set -o errexit

# always exit zero - let the cucumber post build script handle reporting
# success or failure based on the cucumber output.
exit 0
