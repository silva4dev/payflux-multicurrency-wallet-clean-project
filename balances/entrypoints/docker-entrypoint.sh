#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bundle install

bundle exec padrino rake db:migrate

bundle exec padrino rake db:seed

bundle exec padrino start -h 0.0.0.0 -p 3000
