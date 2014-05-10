#!/usr/bin/env bash

if [ "$USER" = "jenkins" ]; then
    echo "INFO: hey, you are jenkins!  loading ~/.bash_profile_ci"
    source ~/.bash_profile_ci
    hash -r
    rbenv rehash

    rm -f .env
    cp .env-jenkins .env

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
