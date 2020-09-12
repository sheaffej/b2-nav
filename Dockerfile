FROM ros:melodic-ros-base-bionic

WORKDIR /root
SHELL [ "bash", "-c"]
ENV ROS_WS /ros

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
    apt-utils \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# slam_toolbox
RUN mkdir -p ${ROS_WS}/src \
&& cd ${ROS_WS}/src \
&& git clone -b melodic-devel https://github.com/SteveMacenski/slam_toolbox.git \
&& source /opt/ros/melodic/setup.bash \
&& cd ${ROS_WS} \
&& apt-get update \
&& rosdep update \
&& rosdep install -y -r --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y

COPY b2_slam_toolbox ${ROS_WS}/src/b2_slam_toolbox/

RUN source /opt/ros/${ROS_DISTRO}/setup.bash \
&& cd ${ROS_WS}/src \
&& catkin_init_workspace \
&& cd ${ROS_WS} \
&& catkin_make 

COPY ./entrypoint.sh /
RUN echo "source /entrypoint.sh" >> .bashrc
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "bash" ]
