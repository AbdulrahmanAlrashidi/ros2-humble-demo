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

## 🚀 First-Time Setup (do this once)

```bash
chmod +x start.sh entrypoint.sh
```

## 🖥️ Run the GUI Smoke Test
```bash
./start.sh
```
---
> ### ⚠️ Important: X11 permission resets on logout/reboot
>
> Run the following command to fix it:
>
> ```bash
> xhost +local:root
> ```

## ⏹️ Stopping the Container
```bash
docker compose down
```

## ▶️ Start the Container (no GUI test)
```bash
docker compose up -d
```

## 🧑‍💻 Then enter the shell
```bash
docker exec -it ros2_humble_demo bash
```

## 🔨  Rebuild the image after changes
```bash
docker compose up --build
```

## 💾 Persistent Data

Everything you put in */ros2_ws/data* inside the container is preserved
across docker compose down and docker compose up — it's just a normal
folder on your host filesystem.

## 🧹 Wipe the data directory 
```bash
rm -rf ros2-humble-demo/data/*
```
