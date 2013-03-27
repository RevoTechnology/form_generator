#!/bin/bash
bundle
rake db:migrate
rake assets:precompile
if [ -f tmp/pids/unicorn.pid ] && [ -e /proc/$(cat tmp/pids/unicorn.pid) ]; then kill -QUIT `cat tmp/pids/unicorn.pid`; fi
bin/unicorn -c config/deploy/unicorn.rb -E production -D
# RAILS_ENV=production script/delayed_job restart
