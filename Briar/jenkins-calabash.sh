#!/usr/bin/env bash

if [ "$USER" = "jenkins" ]; then
    echo "INFO: hey, you are jenkins!  loading ~/.bash_profile_ci"
    source ~/.bash_profile_ci
    hash -r
    rbenv rehash
fi

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

# build the -cal target to get it on the phone
set +o errexit

xcodebuild \
    -derivedDataPath "${CAL_BUILD_DIR}" \
    -workspace "${XC_WORKSPACE}" \
    -scheme "${TARGET_NAME}" \
    -sdk iphonesimulator \
    -configuration "${CAL_BUILD_CONFIG}" \
    clean build | rbenv exec bundle exec xcpretty -c

RETVAL=${PIPESTATUS[0]}

set -o errexit

if [ $RETVAL != 0 ]; then
    echo "FAIL:  could not build"
    exit $RETVAL
fi

# remove any stale targets
rbenv exec bundle exec briar rm sim-targets

# Disable exiting on error so script continues if tests fail
set +o errexit

#   - iPad 6, iPad 7, iPhone, iPhone 4in, iPhone 4in 64bit (instruments)
#   - iPad 6 sim launcher


APP_BUNDLE_PATH="${CAL_BUILD_DIR}/Build/Products/${CAL_BUILD_CONFIG}-iphonesimulator/${TARGET_NAME}.app"

rbenv exec bundle exec cucumber -p sim61_4in          -f json -o ci-reports/calabash/ipad-61-4in.json $TAGS
rbenv exec bundle exec cucumber -p sim71_4in         -f json -o ci-reports/calabash/ipad-71-4in.json $TAGS
rbenv exec bundle exec cucumber -p sim71_64b         -f json -o ci-reports/calabash/ipad-71-4in-64b.json $TAGS
rbenv exec bundle exec cucumber -p sim61r            -f json -o ci-reports/calabash/ipad-61-3.5in.json $TAGS
rbenv exec bundle exec cucumber -p sim71r            -f json -o ci-reports/calabash/ipad-71-3.5in.json $TAGS

rbenv exec bundle exec cucumber -p sim61_ipad_r      -f json -o ci-reports/calabash/ipad-61.json $TAGS
rbenv exec bundle exec cucumber -p sim71_ipad_r      -f json -o ci-reports/calabash/ipad-71.json $TAGS
rbenv exec bundle exec cucumber -p sim71_ipad_r_64b  -f json -o ci-reports/calabash/ipad-71-64b.json $TAGS

rbenv exec bundle exec cucumber -p sim61_sl     -f json -o ci-reports/calabash/ipad-61-no-instruments.json $TAGS


RETVAL=$?

set -o errexit

if [ ! -d ${JSON_REPORT_DIR} ]; then
    mkdir -p ${JSON_REPORT_DIR}
fi

exit $RETVAL
