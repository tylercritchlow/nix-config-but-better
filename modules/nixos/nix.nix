# Nix store and garbage collection policy for the desktop.
{ ... }:
{
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    # Nix store optimisation uses hardlinks, not Btrfs reflinks.
    # The desktop uses bees for extent deduplication instead.
    auto-optimise-store = false;
    keep-going = true;
    warn-dirty = false;
    log-lines = 25;
    connect-timeout = 5;
    # Free store space under pressure (bytes).
    min-free = 10737418240; # 10 GiB
    max-free = 32212254720; # 30 GiB
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
}
