{ ... }:
{
  imports = [
    ./packages.nix
    ./shell/fish.nix
    ./editors/vscode.nix
    ./programs/git.nix
    ./programs/calendars.nix
    ./editors/vim.nix
    ./desktop
  ];

  # Keep device/folder pairing editable in the local Syncthing web UI.
  services.syncthing = {
    enable = true;
    guiAddress = "127.0.0.1:8384";
  };

  home = {
    username = "nothr";
    homeDirectory = "/home/nothr";

    # Initial Home Manager compatibility version; keep after upgrades.
    stateVersion = "26.05";
  };
}
