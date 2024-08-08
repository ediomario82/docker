#!/bin/bash

docker run -d \
        -e ENABLE_LETSENCRYPT=True \
        -e DOMAIN_NAME=speedtest.yourdomain.com \
        -e USER_EMAIL=you@yourdomain.pro \
        --restart=unless-stopped \
        --name openspeedtest  \
        -p 8080:3000 \
        -p 9443:3001 \
        openspeedtest/latest
