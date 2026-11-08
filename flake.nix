{
  description = "Optimized NixOS + Home Manager flake (Linux desktop)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

    grok-bot-nix.url = "github:d-513/grok-bot-nix";
    grok-bot-nix.inputs.nixpkgs.follows = "nixpkgs";

    # CachyOS-patched kernels. The "release" branch is built by upstream Hydra
    # and guaranteed present in the lantian Attic cache.
    # Do NOT override its nixpkgs input: that would cause a mismatch between the
    # CachyOS patches and the kernel version.
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };

  outputs =
    inputs:
    let
      me = (import ./config.nix).me;
      username = me.username;
    in
    {
      nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs me username;
        };
        modules = [
          inputs.home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [ inputs.grok-bot-nix.overlays.default ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs me username;
            };
            home-manager.users.${username} = import ./home/desktop.nix;
          }
          ./configurations/nixos/desktop.nix
        ];
      };

      formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
