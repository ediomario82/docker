#!/bin/bash

docker create volume uptime-kuma

docker run -d \
             -m 512m \
             --memory-swap 1G \
             --cpus 0.25 \
              --restart=always \
              -p 3001:3001
              -v uptime-kuma:/app/data \
              --name uptime-kuma louislam/uptime-kuma:1
