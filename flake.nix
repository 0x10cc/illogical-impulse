{
  description = "nix wrapper around illogical-impulse";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    ii = {
      url = "github:end-4/dots-hyprland";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-parts,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
    systems = lib.systems.flakeExposed;
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      inherit systems;

      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;
      };

      flake.homeModules = rec {
        ii-qs = import ./flake/modules/home-manager.nix {inherit lib inputs;};
        default = ii-qs;
      };
    };
}
