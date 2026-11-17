{ pkgs, ... }:
{
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernelPackages = pkgs.linuxPackages_latest;

    # Encrypted swap; encrypted root is in hardware-configuration.nix.
    initrd.luks.devices."luks-4cf20413-3f63-4000-9772-c2fc63acfc4f" = {
      device = "/dev/disk/by-uuid/4cf20413-3f63-4000-9772-c2fc63acfc4f";
    };
  };
}
