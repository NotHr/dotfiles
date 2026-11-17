{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnumake
    xournalpp

    # Calendar and CalDAV synchronisation
    khal
    vdirsyncer

    # Documents and Markdown writing
    libreoffice-fresh
    pandoc
    typst
    apostrophe
    gedit

    # PDF reading and manipulation
    evince
    pdfarranger
    pdftk

    # Terminal browser, file sync, and client-side encryption
    links2
    syncthing
    cryptomator

    # Mastodon and RSS
    toot
    newsboat

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
