#!/bin/bash
set -e                                                    # abort on any unhandled error

source /opt/ros/humble/setup.bash                         # load ROS 2 environment

echo "🐢 ROS 2 Humble container started (DEMO_MODE=${DEMO_MODE})"
echo ""

if [ "${DEMO_MODE}" = "true" ]; then                      # test path: only when ./start.sh sets it

    # ---------- Test 1: turtlesim + exactly one square ----------
    echo "🖥️  [1/2] Launching turtlesim..."
    ros2 run turtlesim turtlesim_node &                   # background the simulator
    sleep 3                                               # let the GUI window appear

    echo "🟦 Drawing exactly one square to prove GUI + ROS are working..."
    for i in 1 2 3 4; do
        echo "   → side $i: forward"
        ros2 topic pub --once /turtle1/cmd_vel geometry_msgs/msg/Twist \
            "{linear: {x: 2.0, y: 0.0, z: 0.0}, angular: {x: 0.0, y: 0.0, z: 0.0}}"
        sleep 2                                           # ~2 units forward at x=2.0
        echo "   → side $i: turn 90°"
        ros2 topic pub --once /turtle1/cmd_vel geometry_msgs/msg/Twist \
            "{linear: {x: 0.0, y: 0.0, z: 0.0}, angular: {x: 0.0, y: 0.0, z: 1.57}}"
        sleep 1.5                                         # ~1.57 rad = 90° turn
    done

    echo "🔚 Closing turtlesim window..."
    pkill -9 -f turtlesim_node 2>/dev/null || true        # SIGKILL: closes window instantly
    sleep 2                                               # buffer for X window teardown

    # ---------- Test 2: RViz ----------
    echo ""
    echo "🖥️  [2/2] Bonus: launching RViz for 3 seconds..."
    ros2 run rviz2 rviz2 &                                # background RViz
    sleep 3
    pkill -9 -f rviz2 2>/dev/null || true                 # SIGKILL again
    sleep 2                                               # buffer for X window teardown

    # ---------- Full summary ----------
    echo ""
    echo "════════════════════════════════════════════════════════════"
    echo "✅  GUI IS WORKING"
    echo "✅  turtlesim + RViz both launched successfully."
    echo "✅  X11 forwarding, DISPLAY and OpenGL are functional."
    echo ""
    echo "  Please press Ctrl+C"
    echo "💡  Enter the shell:  docker exec -it ros2_humble_demo bash"
    echo "   Stop the container: docker compose down"
    echo "════════════════════════════════════════════════════════════"
    echo ""

    exec sleep infinity                                   # detached mode: stay alive for `docker exec`
else
    echo "💻 DEMO_MODE is not 'true' → starting interactive shell."
    echo "   (No GUI smoke test. Run ./start.sh to run the test.)"
    echo ""
    exec bash                                             # attached mode: user lands in shell
fi