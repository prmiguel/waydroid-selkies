# Docker Waydroid

This project provides a Docker container for Waydroid.

## Prerequisites

Waydroid requires specific kernel modules (`binder_linux` and `ashmem_linux`) to be loaded on the host system. The container shares the host's kernel, so these modules must be installed and loaded on the host, not just inside the container.

### Install Waydroid modules on Host (Ubuntu/Debian)

Run the following commands on your host machine to install the necessary drivers:

```bash
sudo apt update
sudo apt install curl ca-certificates -y
curl -s https://repo.waydro.id | sudo bash
sudo apt install waydroid -y
```

After installation, verify the modules are loaded:

```bash
lsmod | grep binder
```

## Usage

To run the container:

```bash
docker run -d \
  --rm \
  --name waydroid \
  --privileged \
  -v /lib/modules:/lib/modules:ro \
  -v /var/lib/waydroid:/var/lib/waydroid \
  -p 3001:3001 \
  waydroid
```

Note: 
- `--privileged` is required to manage kernel features (binderfs).
- `-v /lib/modules:/lib/modules:ro` allows the container to load the necessary kernel modules (`binder_linux`) matching your host kernel.
- `-v /var/lib/waydroid:/var/lib/waydroid` is optional but recommended to persist Waydroid data.

