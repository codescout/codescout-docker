#!/bin/bash

NAME="testproject"
GIT_URL="https://github.com/sosedoff/opentable.git"
PROJECT_PATH="/project"

# Remove an existing container first
docker rm $NAME > /dev/null

# Clone repo to the next container
docker run --name=$NAME codecheck/codecheck git clone $GIT_URL $PROJECT_PATH

# Commit container with cloned repo
IMAGE_ID=$(docker commit $NAME)

# Execute metrics
docker run --rm=true $IMAGE_ID sandi_meter -d -p $PROJECT_PATH
docker run --rm=true $IMAGE_ID brakeman $PROJECT_PATH
docker run --rm=true $IMAGE_ID flog --19 -q -g $PROJECT_PATH
docker run --rm=true $IMAGE_ID rails_best_practices $PROJECT_PATH

# Remove image
docker rmi $IMAGE_ID