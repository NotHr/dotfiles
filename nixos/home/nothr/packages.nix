{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kitty
    discord
    prismlauncher
    zola
    protonmail-desktop
    gh
    codex
    chromium
    pi-coding-agent
  ];
}
