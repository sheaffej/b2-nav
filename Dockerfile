FROM ros:melodic-ros-base-bionic

WORKDIR /root
SHELL [ "bash", "-c"]
ENV ROS_WS /ros

# RUN LINE BELOW TO REMOVE debconf ERRORS (MUST RUN BEFORE ANY apt-get CALLS)
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
    apt-utils \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Install additional ROS packages
RUN apt-get update \
&& apt-get install -y --no-install-recommends \
    ros-melodic-move-base \
    ros-melodic-amcl \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create ROS workspace
RUN source /opt/ros/${ROS_DISTRO}/setup.bash \
&& mkdir -p ${ROS_WS}/src \
&& cd ${ROS_WS}/src \
&& catkin_init_workspace


# Intsall slam_toolbox
RUN cd ${ROS_WS}/src \
&& git clone -b melodic-devel https://github.com/SteveMacenski/slam_toolbox.git \
&& source /opt/ros/melodic/setup.bash \
&& cd ${ROS_WS} \
&& apt-get update \
&& rosdep update \
&& rosdep install -y -r --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y

RUN source /opt/ros/${ROS_DISTRO}/setup.bash \
&& cd ${ROS_WS}/src \
&& cd ${ROS_WS} \
&& catkin_make 


# Intstall B2 packages
COPY b2_slam_toolbox ${ROS_WS}/src/b2_slam_toolbox
COPY b2_nav ${ROS_WS}/src/b2_nav

RUN source /opt/ros/${ROS_DISTRO}/setup.bash \
&& cd ${ROS_WS}/src \
&& cd ${ROS_WS} \
&& catkin_make 


COPY ./entrypoint.sh /
RUN echo "source /entrypoint.sh" >> .bashrc
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "bash" ]
