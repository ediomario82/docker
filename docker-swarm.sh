#!/bin/bash

## CRIANDO CLUSTER DOCKER COM SWARM ###
#comando para criar o cluster swarm
docker swarm init --advertise-addr

#Comando para verificar os nodes do cluster
docker node ls

#comando para promover um node para manager
docker node promote (nodename)
#Subir a aplicação no cluster swarm
docker stack deploy -c docker-compose.yml (nomedastack)
docker swarm join --token
#remover um um node prara testar balanceamento de carga 
docker node rm (idnode)
#atualizar servico no cluster
docker service update --force (nomedastack)


