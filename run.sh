#!/bin/bash

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
docker run --rm=true $IMAGE_ID sandi_meter -d -p $PROJECT_PATH
docker run --rm=true $IMAGE_ID brakeman $PROJECT_PATH
docker run --rm=true $IMAGE_ID flog --19 -q -g $PROJECT_PATH
docker run --rm=true $IMAGE_ID rails_best_practices $PROJECT_PATH

# Remove image
docker rmi $IMAGE_ID