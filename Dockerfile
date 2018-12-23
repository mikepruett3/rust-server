FROM debian:stable-slim

# Setting all the Environment Variables
ARG LANGUAGE=en_US.UTF-8
ARG PORT=28015
ARG RCON_PORT=28016

ENV LANG=${LANGUAGE} \
    PORT=${PORT} \
    RCON_PORT=${RCON_PORT} \
    RCON_WEB=1 \
    RCON_PASS="password" \
    SERVERNAME="My Rust Server" \
    SEED=12345 \
    TICK=10 \
    SAVEINT=600 \
    MAXPLAYERS=10 \
    WORLDSIZE=4000

# Building OS, and installed steamcmd
RUN \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y locales locales-all && \
    locale-gen ${LANGUAGE} && \
    apt-get install -y software-properties-common && \
    apt-add-repository non-free && \
    apt-get update && \
    echo steam steam/question select "I AGREE" | debconf-set-selections && \
    echo steam steam/license note '' | debconf-set-selections && \
    apt-get install -y \
        nano \
        curl \
        wget \
        mesa-utils \
        net-tools \
        unzip \
        steamcmd && \
    apt-get clean && \
    echo "LANG=${LANGUAGE}" >> /etc/environment

# Download Rust Dedicated Server via SteamCMD
RUN \
    /usr/games/steamcmd \
        +login anonymous \
        +force_install_dir /app \
        +app_info_update 1 \
        +app_update 258550 validate \
        +quit;

# Set up Enviornment
RUN \
    useradd --home /app --gid root --system Rust && \
    chown Rust:root -R /app && \
    chown Rust:root -R /app/server

COPY --chown=Rust:root ./server.sh /app/server.sh

USER Rust

WORKDIR /app

CMD ["/bin/bash"]

ONBUILD USER root

EXPOSE ${PORT}/udp
EXPOSE ${PORT}/tcp
EXPOSE ${RCON_PORT}/tcp

# Volumes for Persistent Server Data
VOLUME "/app/server"
