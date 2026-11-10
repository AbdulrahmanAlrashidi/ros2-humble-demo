# ─────────────────────────────────────────────────────────────────────
# Dockerfile — builds the ROS 2 Humble demo image.
# Run via `docker compose up --build`.
# ─────────────────────────────────────────────────────────────────────

# base image; "desktop-full" includes turtlesim, RViz, Gazebo
FROM osrf/ros:humble-desktop-full  

# CWD for all following commands + container default
WORKDIR /ros2_ws                   

# auto-source ROS in every shell
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc   

# bring the startup script into the image
COPY entrypoint.sh /entrypoint.sh  

# make it executable (COPY may drop the +x bit)
RUN chmod +x /entrypoint.sh        

# exec form → PID 1, receives SIGTERM, no shell wrapper
ENTRYPOINT ["/entrypoint.sh"]      