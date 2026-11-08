{
  pkgs,
  inputs,
  me,
  username,
  ...
}:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware-configuration.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/btrfs.nix
  ];

  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];

  nix.settings = {
    extra-substituters = [ "https://cache.lantian.pub/lantian" ];
    extra-trusted-public-keys = [ "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ=" ];
  };

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-zen4;

  boot.loader.limine.enable = true;
  boot.loader.limine.maxGenerations = 10;
  boot.loader.limine.extraEntries = ''
    /Windows
      protocol: efi_chainload
      path: guid(4926dbf6-be34-4783-a43e-f8c4e62fabd8):/EFI/Microsoft/Boot/bootmgfw.efi
  '';
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "tylers-desktop-nix";
  networking.networkmanager.enable = true;

  services.desktopManager.plasma6.enable = true;
  services.displayManager.plasma-login-manager.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    elisa
  ];

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [
    "nvidia"
    "amdgpu"
  ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
  };

  time.timeZone = "America/Denver";
  time.hardwareClockInLocalTime = true;
  i18n.defaultLocale = "en_US.UTF-8";

  programs.zsh.enable = true;
  users.users.${username} = {
    isNormalUser = true;
    description = me.fullname;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  programs.gamemode.enable = true;

  services.tailscale.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
  };

  system.stateVersion = "25.11";
}
