#!/bin/bash

docker container run -dit \
    -p 8080:5000 -p 8000:8000 \
    --tmpfs /opt/omd/sites/cmk/tmp:uid=1000,gid=1000 \
    -v monitoring:/omd/sites --name checkmk \
    -v /etc/localtime:/etc/localtime:ro \
    --restart always \
    checkmk/check-mk-raw:2.3.0-latest
