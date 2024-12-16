{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixOS/nixpkgs/nixos-unstable";
    nix-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixvim = {
    	url = "github:nix-community/nixvim";
    };
    home-manager.url = "github:nix-community/home-manager"; # module to manage home config files
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
  };
outputs = inputs: let
    system = "x86_64-linux";
    inherit (inputs.nixpkgs) lib; # this is the same as `lib = inputs.nixpkgs.lib;`

    stable_overlay = final: _prev: {stable = import inputs.nix-stable {system = final.system;};};
    overlays = [stable_overlay]; # this lets us access stable packages by doing `pkgs.stable`

    pkgs = import inputs.nixpkgs {
      inherit system overlays; # same thing as `system = system; overlays = overlays;`
      config.allowUnfree = true; # allow proprietary software
    };
  in {
    nixosConfigurations = {
      Volibear = lib.nixosSystem {
        specialArgs = {inherit pkgs inputs;};
        modules = [./configuration.nix];
      };
    };
};
}
