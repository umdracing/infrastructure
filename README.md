# Infrastructure
NixOS configuration for UMD Racing e.V. IT infrastructure

This repository aims to track the configuration of the IT infrastructure, using NixOS with Colmena for declarative system management. It is currently very much w.i.p. and more documentation will follow

## Rough plan

- NixOS as host system
- Colmena for deployment
- Sops-nix for secrets management
- Authentik for SSO for the various services
- Headscale for VPN configuration

## Setup

Create personal SSH key for testing purposes, e.g. using ```ssh-keygen -t ed25519```, and add the following to your ```~/.ssh/config``` file on your host machine:
```
Host localhost
    IdentityFile ~/.ssh/your-newly-created-keyfile
    Port 2222
```
Next, add your public key to the authorized keys in ```./vps/vm/flake.nix```. This approach will likely change in the future.

Note also, that this affects any localhost ssh connections on your device, which may interfere with other projects.

## Use
Enter the dev env with
```bash
$ nix develop -i
```
