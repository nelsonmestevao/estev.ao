{
  description = "Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    beam-flakes = {
      url = "github:elixir-tools/nix-beam-flakes";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    beam-flakes,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [beam-flakes.flakeModule];

      systems = ["aarch64-darwin" "x86_64-darwin" "x86_64-linux"];

      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;

        beamWorkspace = {
          enable = true;
          devShell = {
            #   languageServers.elixir = true;
            #   languageServers.erlang = false;
            phoenix = true;
            extraPackages = with pkgs; [
              ruby_4_0
            ];
          };
          versions = {
            fromToolVersions = ./.tool-versions;
          };
        };
      };
    };
}
