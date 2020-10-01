#!/usr/bin/env bash

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
${MYDIR}/c.sh shell $@

# IMAGE="sheaffej/b2-nav"
# LABEL="b2"

# MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# PROJECT_DIR="$MYDIR/.."
# DOWNLOADS_DIR=~/Downloads


# docker run -it --rm \
# --label ${LABEL} \
# --net host \
# --privileged \
# --env DISPLAY \
# -e ROS_MASTER_URI \
# --mount type=bind,source=$PROJECT_DIR/b2_nav,target=/ros/src/b2_nav \
# --mount type=bind,source=${DOWNLOADS_DIR},target=/root/Downloads \
# $IMAGE /bin/bash
