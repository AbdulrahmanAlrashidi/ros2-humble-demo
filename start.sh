#!/bin/bash
set -e                                                    # abort on any unhandled error

echo "🔓 Granting X11 access to local root (needed after logout/reboot)..."
xhost +local:root > /dev/null                             # allow container GUI → host X server

echo "🚀 Building and starting ROS 2 Humble container (DEMO_MODE=true)..."
DEMO_MODE=true docker compose up -d --build               # detached + force test path

echo ""
echo "⏳ Running GUI smoke test (watch the windows on your screen)..."
echo ""
docker compose logs -f &                                  # follow container output in background
LOGS_PID=$!                                               # capture PID so we can kill it later

TIMEOUT=60                                                # safety cap (test takes ~15–20s)
ELAPSED=0
while [ $ELAPSED -lt $TIMEOUT ]; do
    if docker compose logs --tail=50 --no-color 2>/dev/null | grep -q "GUI IS WORKING"; then
        break                                             # completion marker found
    fi
    sleep 1
    ELAPSED=$((ELAPSED + 1))
done

kill $LOGS_PID 2>/dev/null || true                        # stop the log follower
wait $LOGS_PID 2>/dev/null || true                        # reap it (no zombie)

echo ""
if [ $ELAPSED -ge $TIMEOUT ]; then
    # Only print a warning if the test actually failed to finish.
    # On success, the full box was already shown by entrypoint.sh above.
    echo "⚠️  Smoke test did NOT complete in ${TIMEOUT}s."
    echo "   Check the logs:  docker compose logs"
    echo ""
fi