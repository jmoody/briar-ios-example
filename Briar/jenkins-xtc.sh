#!/usr/bin/env bash

if [ "$USER" = "jenkins" ]; then
    rm -f .env
    cp .env-jenkins .env
fi

rbenv exec bundle install

set +o errexit
rbenv exec bundle exec briar xtc jenkins-ci default
RETVAL=$?

set -o errexit

echo "ended with status '$RETVAL'"

exit 0
