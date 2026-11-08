# Desktop applications, fonts, and icons.
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Editors / browsers
    helix
    vscodium
    firefox

    # Terminal helpers (Ghostty/tmux/zsh via programs.*)
    curl
    cloudflared

    # Media / creative
    vlc
    obs-studio
    libreoffice
    kdePackages.kcalc
    localsend
    xournalpp

    # Gaming tools
    prismlauncher
    mangohud
    lutris

    # Fonts / icons
    nerd-fonts.fira-code
    adwaita-icon-theme
    hicolor-icon-theme
  ];
}
