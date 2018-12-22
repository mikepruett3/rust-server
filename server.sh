#!/usr/bin/env bash

set -euo pipefail

export LD_LIBRARY_PATH=:`dirname $0`/RustDedicated_Data/Plugins/x86_64

CMD="./RustDedicated \
    +rcon.web $RCON_WEB \
    +rcon.password "$RCON_PASS" \
    +rcon.port $RCON_PORT \
    +server.port $PORT \
    +server.hostname "$SERVERNAME" \
    +server.seed $SEED \
    +server.tickrate $TICK \
    +server.saveinterval $SAVEINT \
    +server.maxplayers $MAXPLAYERS \
    +server.worldsize $WORLDSIZE \
    +nav_disable \
    -logfile -"

exec $CMD $@