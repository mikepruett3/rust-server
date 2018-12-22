# Rust Dedicated Server
Docker Image to run a dedicated Rust Server.

## Usage

```bash
docker run \
  --name=rust \
  --restart unless-stopped \
  --detach \
  -it \
  -e SERVERNAME="My Rust Server" \
mikepruett3/rust-server ./server.sh
```

SERVER_NAME = Ingame Server Name

SEED = Game Seed for Map Generation

PORT = Server Port Number

RCON_PORT = RCON Port Number

RCON_PASS = Password for RCON

Where **PORT=** and **Expose Port** Numbers are the same!

Example: Server to run on port 8080

```bash
  -e PORT=8080 \
  -p 8080:8080 \
```

This way a single server can support multiple Rust Dedicated Server containers.

The container is created as a Detached container. If you want to connect to the running Dedicate Server console, use the following command:

```bash
docker attach rust
```

You can type in exit to leave the server console/container, since the restart policy is set to unless-stopped the container (and Dedicated Server) will restart automatically.