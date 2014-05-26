#!/usr/bin/env bash

if [ "$USER" = "jenkins" ]; then
    echo "INFO: hey, you are jenkins!  loading ~/.bash_profile_ci"
    source ~/.bash_profile_ci
    hash -r
    rbenv rehash

    rm -f .env
    cp .env-jenkins .env


# briar todo
# briar needs the notion of series and locale

# todo

# how do we automatically set the device set?

# we also want to kick off jobs against the simulator
# - no failures - just reports!
#   - iPad 6, iPad 7, iPhone, iPhone 4in, iPhone 4in 64bit (instruments)
#   - iPad 6 sim launcher
# - need cucumber result in json

# - need to publish results to gh-pages auto magically
# jenkins job needs to capture XTC run output as build report with REGEX

else
   echo "INFO: you are _not_ jenkins! will not load ~/.bash_profile_ci"
fi

rbenv exec bundle install

set +o errexit
rbenv exec bundle exec briar xtc jenkins-ci default
set -o errexit

RETVAL=$?

echo "ended with status '$RETVAL'"

exit 0
