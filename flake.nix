{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixOS/nixpkgs/nixos-unstable";
    nix-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixvim.url = "github:nix-community/nixvim";
    home-manager.url = "github:nix-community/home-manager"; # module to manage home config files
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
  };
outputs = inputs: let
    system = "x86_64-linux";
    inherit (inputs.nixpkgs) lib; # this is the same as `lib = inputs.nixpkgs.lib;`

  in {
    nixosConfigurations = {
      Volibear = lib.nixosSystem {
        specialArgs = {inherit inputs system;};
        modules = [./configuration.nix];
      };
    };
};
}
