#!/bin/bash

docker rm -f waydroid
docker build -t waydroid .
docker run -d --rm --name waydroid --privileged --shm-size=1g -v /lib/modules:/lib/modules:ro -v /var/lib/waydroid:/var/lib/waydroid -p 3001:3001 waydroid
docker exec -it --user=abc waydroid bash
start-waydroid