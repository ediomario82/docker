#!/bin/bash

## CRIANDO CLUSTER DOCKER COM SWARM ###
#comando para criar o cluster swarm
docker swarm init --advertise-addr 192.168.XX.XX

#Comando para verificar os nodes do cluster
docker node ls

#comando para promover um node para manager
docker node promote (hostname)
#Subir a aplicação no cluster swarm
docker stack deploy -c docker-compose.yml (nomedastack)
docker swarm join --token
#remover um um node prara testar balanceamento de carga 
docker node rm (idnode)
#atualizar servico no cluster
docker service update --force (nomedastack)

###########################
####docker-compose.yml#####
###########################

version: "3.8"

services:
  site:
    image: developer10/site
    deploy:
      replicas: 5
      placement:
        constraints: [node.role==worker]
    ports:
      - 3000:80
    depends_on:
      - db
  db:
    image: postgres:13
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
    ports:
      - 5432:5432 
    volumes:
      - postgres_data:/var/lib/postgresql/data/
    deploy:
      placement:
        constraints: [node.role == manager] 
  visualizer:
    image: dockersamples/visualizer:stable
    ports:
    - "8888:8080"
    volumes:
    - "/var/run/docker.sock:/var/run/docker.sock"
    deploy:
      placement:
        constraints: [node.role == manager]        

volumes:
  postgres_data:


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
