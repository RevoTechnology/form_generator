#!/bin/bash
gem install bundle
bundle
rake db:create
rake db:migrate
rake db:seed