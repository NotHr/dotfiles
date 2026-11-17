{ ... }:
{
  imports = [
    ./audio.nix
    ./bluetooth.nix
  ];

  services = {
    xserver = {
      enable = true;
      windowManager.i3.enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    printing.enable = true;
  };

  programs.firefox.enable = true;
}
