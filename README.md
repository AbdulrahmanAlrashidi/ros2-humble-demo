<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:22314E,100:2496ED&height=120&section=header&text=ROS%202%20Humble%20Demo&fontSize=40&fontColor=ffffff&animation=fadeIn" alt="header" />
</div>


<div align="center">

[![ROS 2](https://img.shields.io/badge/ROS_2-Humble-22314E?style=for-the-badge&logo=ros&logoColor=white)](https://docs.ros.org/en/humble/)
[![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docs.docker.com/compose/)

*Docker-based ROS 2 Humble environment with an automatic GUI smoke test for X11 / OpenGL verification.*
</div>



<div align="center">
<img src="https://em-content.zobj.net/source/twitter/376/turtle_1f422.png" alt="Turtle" width="80" />
</div>


A ready-to-run ROS 2 Humble container with an automatic **GUI smoke test**
(turtlesim draws a square, then RViz opens briefly) so you instantly know
your X11 / OpenGL setup works on this machine.

---

## ⚠️ X11 Display Access (Run Once Per Session)

 Allow Docker containers to open GUI windows (`turtlesim`, `RViz`) on your screen. This permission resets after logging out or rebooting:

```bash
xhost +local:root
```

## 🖥️ Run with GUI Smoke Test (`DEMO_MODE=true`)

Runs the `turtlesim` and `RViz` verification test first, then drops you into the interactive shell:
```bash
DEMO_MODE=true docker compose run --rm --build ros2
```
---




## ▶️ Run Without GUI (Interactive Shell Only)

Skips the GUI test (`DEMO_MODE=false` default) and drops you straight into the ROS 2 shell:
```bash
docker compose run --rm --build ros2
```


## ⏹️ Stop & Clean Up Containers

Type `exit` inside the container shell to close and auto-remove it (`--rm`), or clean up any leftover containers with:
```bash
docker compose down
```

## 🔨  Rebuild the image after changes
```bash
docker compose up --build
```

## 💾 Persistent Data

Everything you put in `/ros2_ws/data` inside the container is preserved across container restarts — it maps directly to `./data` on your host filesystem.

## 🧹 Wipe the data directory 
```bash
rm -rf ros2-humble-demo/data/*
```
