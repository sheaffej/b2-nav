#!/usr/bin/env bash

IMAGE="sheaffej/b2-slam-toolbox"
LABEL="b2"

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PROJECT_DIR="$MYDIR/.."
DOWNLOADS_DIR=~/Downloads


docker run -it --rm \
--label ${LABEL} \
--net host \
--privileged \
--env DISPLAY \
-e ROS_MASTER_URI \
--mount type=bind,source=$PROJECT_DIR/b2_slam_toolbox,target=/ros/src/b2_slam_toolbox \
--mount type=bind,source=${DOWNLOADS_DIR},target=/root/Downloads \
$IMAGE /bin/bash
