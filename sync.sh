#!/bin/bash

# auto-determine source directory (Vagrant/native environment)
if [[ -e /app-src ]] ; then
  APP_SOURCE=/app-src
else
  if [[ -e ../richdocuments ]] ; then
    APP_SOURCE=../richdocuments
  else
    echo "No source directory found. Please consider README for details." >&2
    exit
  fi
fi

sudo rm -rf ./nextcloud-apps/richdocuments
sudo cp -r $APP_SOURCE ./nextcloud-apps/richdocuments
sudo chown -R www-data ./nextcloud-apps/richdocuments
