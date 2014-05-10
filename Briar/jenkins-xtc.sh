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

