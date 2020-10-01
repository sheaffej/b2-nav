#!/usr/bin/env bash

# IMAGE="sheaffej/b2-nav"
# LABEL="b2"
# CONTAINER="b2-nav"

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# PROJECT_DIR="$MYDIR/.."
# DOWNLOADS_DIR=~/Downloads

# docker run -d --rm \
# --name ${CONTAINER} \
# --label ${LABEL} \
# --net host \
# --privileged \
# --env DISPLAY \
# -e ROS_MASTER_URI \
# --mount type=bind,source=$PROJECT_DIR/b2_nav,target=/ros/src/b2_nav \
# --mount type=bind,source=${DOWNLOADS_DIR},target=/root/Downloads \
# $IMAGE roslaunch b2_nav nav_all.launch

$MYDIR/c.sh daemon roslaunch b2_nav nav_all.launch