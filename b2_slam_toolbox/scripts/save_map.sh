#!/usr/bin/env bash

# NAME="b2-downstairs"

rosservice call /slam_toolbox/serialize_map b2-downstairs_serialized

rosservice call /slam_toolbox/save_map "name:
  data: 'b2-downstairs'"

