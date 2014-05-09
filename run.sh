#!/bin/bash

set -e

NAME="testproject"
GIT_URL=$1
GIT_SHA=$2
PROJECT_PATH="/project"

if [ -z $GIT_URL ]; then
  echo "Git url required"
  exit 1
fi

if [ -z $GIT_SHA ] ; then
  GIT_SHA="master"
fi

# Remove an existing container first
docker rm $NAME > /dev/null

# Clone repo to the next container
docker run --name=$NAME codecheck git clone $GIT_URL $PROJECT_PATH

# Commit container with cloned repo
IMAGE_ID=$(docker commit $NAME)

# Execute metrics
docker run --rm=true $IMAGE_ID sandi_meter -d -p --json $PROJECT_PATH > sandi_meter.json
docker run --rm=true $IMAGE_ID brakeman --format json $PROJECT_PATH > brakeman.json
docker run --rm=true $IMAGE_ID flog --json --19 -q -g $PROJECT_PATH > flog.json
docker run --rm=true $IMAGE_ID rails_best_practices --format json $PROJECT_PATH > rails_best_practices.json

# Remove image
docker rmi $IMAGE_ID
