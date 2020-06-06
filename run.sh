#!/bin/bash

source .env

if [ -z "$1" ]; then
	MODE=-d
else
	MODE="-it --rm"
fi 

if [ -z "$@" ]; then
	CMD="face_recognition /wd/data/known_people /wd/data/images/TestImage.jpg --show-distance True --tolerance 0.6"
else
	CMD="$@"
fi

echo "docker container run ${RUN_OPTS} ${CONTAINER_NAME} ${MODE} ${NETWORK} ${PORT_MAP} ${VOL_MAP} ${REGISTRY}${IMAGE}${TAG} $CMD"
docker container run ${RUN_OPTS} ${CONTAINER_NAME} ${MODE} ${NETWORK} ${PORT_MAP} ${VOL_MAP} ${REGISTRY}${IMAGE}${TAG} $CMD

