#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bundle install

bundle exec padrino rake db:migrate

bundle exec padrino rake db:seed

bundle exec rerun --background -- thin start --port 3003 -R config.ru
