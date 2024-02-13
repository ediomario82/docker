#!/bin/bash

# Criar rede zabbix-net
docker network create zabbix-net --subnet 172.20.0.0/16 --ip-range 172.20.240.0/20

docker run --name mysql-server -t \
             -e MYSQL_DATABASE="zabbix" \
             -e MYSQL_USER="zabbix" \
             -e MYSQL_PASSWORD="zabbix_pwd" \
             -e MYSQL_ROOT_PASSWORD="root_pwd" \
             --network=zabbix-net \
             -v dbData:/var/lib/mysql \
             --restart unless-stopped \
             -d mysql:8.0.36 \
             --character-set-server=utf8mb4 --collation-server=utf8mb4_bin \

docker run --name zabbix-server-mysql -t \
             -e DB_SERVER_HOST="mysql-server" \
             -e MYSQL_DATABASE="zabbix" \
             -e MYSQL_USER="zabbix" \
             -e MYSQL_PASSWORD="zabbix_pwd" \
             -e MYSQL_ROOT_PASSWORD="root_pwd" \
             --network=zabbix-net \
             --restart unless-stopped \
             -d zabbix/zabbix-server-mysql:alpine-6.0-latest
docker run --name zabbix-java-gateway -t \
             --network=zabbix-net \
             --restart unless-stopped \
             -d zabbix/zabbix-java-gateway:alpine-6.0-latest

docker run --name zabbix-server-mysql -t \
             -e DB_SERVER_HOST="mysql-server" \
             -e MYSQL_DATABASE="zabbix" \
             -e MYSQL_USER="zabbix" \
             -e MYSQL_PASSWORD="zabbix_pwd" \
             -e MYSQL_ROOT_PASSWORD="root_pwd" \
             -e ZBX_JAVAGATEWAY="zabbix-java-gateway" \
             --network=zabbix-net \
             -p 10051:10051 \
             --restart unless-stopped \
             -d zabbix/zabbix-server-mysql:alpine-6.0-latest

# Criar container Grafana
docker volume create grafana-storage

docker run --name grafana \
           -e "GF_SERVER_ROOT_URL=http://grafana.local" \
           -e "GF_SECURITY_ADMIN_PASSWORD=passwd" \
           -e "GF_INSTALL_PLUGINS=alexanderzobnin-zabbix-app" \
           -e "GF_PLUGINS_ALLOW_LOADING_USIGNED_PLUGINS=alexanderzobnin-zabbix-datasource" \
           --network=zabbix-net \
           --restart unless-stopped \
           -p 3000:3000 \
           -v grafana-storage:/var/lib/grafana \
           -d grafana/grafana-enterprise
      
