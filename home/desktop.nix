# Home Manager entry for the desktop NixOS host.
{ inputs, ... }:
{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    ../modules/home/packages.nix
    ../modules/home/shell.nix
    ../modules/home/terminal.nix
    ../modules/home/git.nix
    ../modules/home/ai-tools.nix
    ../modules/home/plasma.nix
  ];

  home.stateVersion = "23.11";
}
