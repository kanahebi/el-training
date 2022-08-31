#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
yarn install
bundle exec rails assets:clobber
bundle exec rails assets:precompile
bundle exec db:migrate
