# Official daloRADIUS Dockerfile
# GitHub: https://github.com/lirantal/daloradius
#
# Build image:
# 1. git pull git@github.com:lirantal/daloradius.git
# 2. docker build . -t lirantal/daloradius
#
# Run the container:
# 1. docker run -p 82:80 -p 8001:8000 -d lirantal/daloradius

FROM debian:11-slim
MAINTAINER Liran Tal <liran.tal@gmail.com>

LABEL Description="daloRADIUS Official Docker based on Debian 11 and PHP7." \
        License="GPLv2" \
        Usage="docker build . -t lirantal/daloradius && docker run -d -p 82:80 -p 8001:8000 lirantal/daloradius" \
        Version="2.0beta"

ENV DEBIAN_FRONTEND noninteractive

# default timezone
ENV TZ America/Sao_Paulo

# PHP install
RUN apt-get update \
  && apt-get install --yes --no-install-recommends \
  ca-certificates \
  apt-utils \
  freeradius-utils \
  tzdata \
  apache2 \
  libapache2-mod-php \
