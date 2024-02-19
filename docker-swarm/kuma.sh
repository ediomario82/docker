#!/bin/bash

# Criar volume para manter dados presistente no container
cd
docker volume create uptime-kuma
# Criar Network
docker network create -d overlay swarm-net

# Criar container com configurações restritas
docker service create \
        --replicas 4 \
        --network swarm-net \
        --constraint  'node.role == worker' \
        --mount type=volume,source=uptime-kuma,destination=/app/data \
        -p 8000:3001 \
        --name kuma \
        louislam/uptime-kuma:latest
