{ ... }:
{
  # Defaults to monthly; NixOS deduplicates mounts of the same filesystem.
  services.btrfs.autoScrub.enable = true;

  # One bees instance covers root, home, and the Nix store together.
  services.beesd.filesystems.root = {
    spec = "/";
    # 1 GiB hash table; bees also uses memory for working data.
    hashTableSizeMB = 1024;
    extraOptions = [
      "--thread-count"
      "2"
      "--loadavg-target"
      "2.0"
    ];
  };
}
