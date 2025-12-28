#!/bin/bash

docker rm -f waydroidu
docker build -f Dockerfile.ubuntu -t waydroidu .
docker run -d --rm --name waydroidu --privileged --shm-size=1g -v /lib/modules:/lib/modules:ro -v /var/lib/waydroid:/var/lib/waydroid -p 3001:3001 waydroid
docker exec -it --user=abc waydroidu bash
start-waydroid