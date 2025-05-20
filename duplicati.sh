docker run -d \
  --name=duplicati \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/Sao_Paulo \
  #-e SETTINGS_ENCRYPTION_KEY= \
  -e CLI_ARGS= `#optional` \
  #-e DUPLICATI__WEBSERVICE_PASSWORD= `#optional` \
  -p 8200:8200 \
  -v /mnt/duplicati/config:/config \
  -v /mnt/backups:/backups \
  -v /mnt/source:/source \
  --restart unless-stopped \
  lscr.io/linuxserver/duplicati:latest
