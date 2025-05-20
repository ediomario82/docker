docker run -d \
  --name=syncthing \
  --hostname=syncthing `#optional` \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/Sao_Paulo \
  -p 8384:8384 \
  -p 22000:22000/tcp \
  -p 22000:22000/udp \
  -p 21027:21027/udp \
  -v /mnt/syncthing/config:/config \
  -v /mnt/data1:/data1 \
  -v /mnt/data2:/data2 \
  --restart unless-stopped \
  lscr.io/linuxserver/syncthing:latest
