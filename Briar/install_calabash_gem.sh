#!/bin/bash
CAL_GEM_DIR="${HOME}/git/calabash-ios/calabash-cucumber"
if [ -d "${CAL_GEM_DIR}" ]; then
  echo "NOTE: installing calabash-cucumber gem"
  current_dir=`pwd`
  cd "${CAL_GEM_DIR}"
  rake install
  cd "${current_dir}"
else
  echo "NOTE: skipping calabash-cucumber gem install"
  echo "NOTE: could not find ${CAL_GEM_DIR} directory"
fi
