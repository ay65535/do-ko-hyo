#!/bin/bash

#
# parameters
#

# name of rails project
PROJECT_NAME=${1:-do-ko-hyo}
echo "project name is: $PROJECT_NAME"

# resolve OneDrive environment variable
shopt -s extglob
OneDrive=("$HOME"/Library/CloudStorage/OneDrive-!(Personal|個人用))

# workspace folder
WORKSPACE_FOLDER="${OneDrive[0]}/src/home/$PROJECT_NAME"

# ----------

#
# generate rails project template
#

rbenv versions

LATEST_VERSION=$(rbenv install -l | grep -v - | tail -1)

# if latest version is not installed, install it
if ! rbenv versions | grep -q "$LATEST_VERSION"; then
  rbenv install "$LATEST_VERSION"
fi

mkdir /tmp/rails 2>/dev/null
pushd /tmp/rails || exit

rbenv local "$LATEST_VERSION"
rbenv local

# install bundler
rbenv exec gem install bundler
rbenv rehash

# create Gemfile
rbenv exec bundle init
rbenv exec bundle add rails --skip-install

# set install path
rbenv exec bundle config set --local path vendor/bundle

# install rails
rbenv exec bundle install

# check installed gems
rbenv exec bundle list

# create rails project
rbenv exec bundle exec rails new "$WORKSPACE_FOLDER" --skip-bundle

# delete unnecessary files
rm -rf .bundle .ruby-version Gemfile Gemfile.lock vendor
popd || exit

# ----------

#
# create rails project
#

# enter rails project
pushd "$WORKSPACE_FOLDER" || exit

# set install path
GITDIR=$(git -C "$WORKSPACE_FOLDER" rev-parse --git-dir)
rbenv exec bundle config set --local path "$GITDIR/vendor/bundle"

# install required gems
rbenv exec bundle install

# show start rails server message
echo "install finished."
echo "to start rails server: rbenv exec bundle exec rails server"

popd || exit
