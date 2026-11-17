{ pkgs, ... }:
{
  home.packages = with pkgs; [
    xournalpp
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
