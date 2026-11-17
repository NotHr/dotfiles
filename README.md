# Dotfiles

Per-device Nix flakes, following dracarys18/dotfiles.

- `devices/notebook/nix/`: existing notebook system and Home Manager configuration, moved unchanged.
- `devices/sheldon/nix/`: upstream home server, copied from commit `c55f78b292dc9cf05d5f10a358b90f6eabd395de`.
- `config/`: upstream application configuration files.
- Root `flake.nix`: compatibility entry point for `#notebook`.
- `backups/` and the pre-existing `nixos/` directory: left untouched.

## Notebook

```sh
make check
make build
make switch
make update
```

## Home server

The server is a reference copy, NOT ready to deploy to your hardware. Before using
`make build HOST=sheldon` or `make switch HOST=sheldon`, replace `hardware.nix`,
review disks, networking, firewall, domains, user `karthihegde`, SSH keys and
service paths. Replace the encrypted files in `secrets/` with your own secrets
and configure your own sops recipients and age key. The upstream ciphertext
cannot be decrypted without the author's private key. Deployment settings in
its flake also target the author's host/user.

No rebuild or activation was performed during migration.
