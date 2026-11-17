{ pkgs, ... }:
{
  users.users.nothr = {
    isNormalUser = true;
    description = "Harshith Madhadi";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.fish.enable = true;
}
