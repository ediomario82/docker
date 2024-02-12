#!/bin/bash

# Criar rede zabbix-net
docker network create zabbix-net --subnet 172.20.0.0/16 --ip-range 172.20.240.0/20

docker run --name mariaDB-server -t \
             -e MYSQL_DATABASE="zabbix" \
             -e MYSQL_USER="zabbix" \
             -e MYSQL_PASSWORD="zabbix_pwd" \
             -e MYSQL_ROOT_PASSWORD="root_pwd" \
             --network=zabbix-net \
             -v mariadb:/var/lib/mysql \
             --restart unless-stopped \
             -d mariadb:10.6.15-focal \
             --character-set-server=utf8mb4 --collation-server=utf8mb4_bin \

docker run --name zabbix-java-gateway -t \
             --network=zabbix-net \
             --restart unless-stopped \
             -d zabbix/zabbix-java-gateway:alpine-6.0-latest

docker run --name zabbix-server-mariadb -t \
             -e DB_SERVER_HOST="mariaDB-server" \
             -e MYSQL_DATABASE="zabbix" \
             -e MYSQL_USER="zabbix" \
             -e MYSQL_PASSWORD="zabbix_pwd" \
             -e MYSQL_ROOT_PASSWORD="root_pwd" \
             -e ZBX_JAVAGATEWAY="zabbix-java-gateway" \
             --network=zabbix-net \
             -p 10051:10051 \
             --restart unless-stopped \
              -d zabbix/zabbix-server-mysql:alpine-6.0-latest

docker run --name zabbix-web-nginx -t \
             -e ZBX_SERVER_HOST="zabbix-server-mariadb" \
             -e DB_SERVER_HOST="mariaDB-server" \
             -e MYSQL_DATABASE="zabbix" \
             -e MYSQL_USER="zabbix" \
             -e MYSQL_PASSWORD="zabbix_pwd" \
             -e MYSQL_ROOT_PASSWORD="root_pwd" \
             --network=zabbix-net \
             -p 80:8080 \
             --restart unless-stopped \
             -d zabbix/zabbix-web-nginx-mysql:alpine-6.0-latest
