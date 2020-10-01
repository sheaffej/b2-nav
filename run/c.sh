#!/usr/bin/env bash

IMAGE="sheaffej/b2-nav"
ROS_DIR="b2_nav"
LABEL="b2"

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PROJECT_DIR="$MYDIR/.."
DOWNLOADS_DIR=~/Downloads

usage() {
    echo
    echo "@0 shell|daemon [arg1] [arg2] ... [argN]"
    echo
    exit 1
}

if [[ $1 == "shell" ]]; then
    MODE="-it"
    shift
elif [[ $1 == "daemon" ]]; then
    MODE="-d"
    shift
else
    usage
fi

docker run ${MODE} --rm \
--label ${LABEL} \
--net host \
--privileged \
--env DISPLAY \
-e ROS_MASTER_URI \
--mount type=bind,source=$PROJECT_DIR/${ROS_DIR},target=/ros/src/${ROS_DIR} \
--mount type=bind,source=${DOWNLOADS_DIR},target=/root/Downloads \
$IMAGE $@
