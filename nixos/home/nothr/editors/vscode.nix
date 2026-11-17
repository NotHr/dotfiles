{ pkgs, ... }:
{
  # Install VSCodium while preserving your existing editor settings.
  home.packages = [ pkgs.vscodium ];
}
