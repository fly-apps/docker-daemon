# Fly Docker Daemon

This is a Docker Daemon that runs on Fly.io and can be used to offload  builds and other tasks to a Fly app running in a city near you.

## Installation

1. Clone this repository
1. `fly launch`, follow the prompts
1. Select `n` when it asks if you want to deploy
1. Create a volume in a region of your choice: `fly volumes create data --size 50 --region ord`
1. Deploy

## Get Connected

1. Create a WireGuard peer with `fly wireguard create`
1. Setup WireGuard with generated config
1. `fly ips private` to get the IP of your Daemon
1. Set the `DOCKER_HOST` env variable using that IP:
    ```
    export DOCKER_HOST=tcp://[fdaa:0:5d2:a7b:81:0:26d4:2]:2375
    ```

# Final Step

1. Delete the Docker Engine from your local system.
1. You probably want to scale your remote Daemon: `fly scale vm dedicated-cpu-2x`