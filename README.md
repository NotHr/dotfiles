# Dotfiles

NixOS and Home Manager configurations, based on [dracarys18/dotfiles](https://github.com/dracarys18/dotfiles).

## Layout

- `devices/notebook/nix/` — notebook configuration (default).
- `devices/sheldon/nix/` — home server reference configuration.
- `config/` — application configs.
- `flake.nix` — compatibility entry point for `#notebook`.
- `nixos/`, `backups/` — previous configuration and backups.

## Usage

```sh
make check   # validate
make build   # build without activating
make switch  # build and activate
make update  # update flake inputs
```

Select another device with `HOST=<name>`.

> `sheldon` is an upstream reference, not deployment-ready. Replace hardware,
> users, SSH keys, secrets and deployment settings; review disks, networking
> and services before use. Its encrypted secrets require the original author's key.
