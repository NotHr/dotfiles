{ ... }:
{
  imports = [
    ./packages.nix
    ./shell/fish.nix
    ./editors/vscode.nix
    ./programs/git.nix
    ./editors/vim.nix
    ./desktop
  ];

  home = {
    username = "nothr";
    homeDirectory = "/home/nothr";

    # Initial Home Manager compatibility version; keep after upgrades.
    stateVersion = "26.05";
  };
}
