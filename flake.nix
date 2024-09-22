# SPDX-FileCopyrightText: 2024 The Input Leap Developers
#
# SPDX-License-Identifier: Apache-2.0

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, ... } @ inputs:
    inputs.flake-utils.lib.eachSystem ["aarch64-linux" "x86_64-linux"]
      (system:
        let
          pkgs = inputs.nixpkgs.outputs.legacyPackages.${system};
        in
        {
          packages = {
            ei-wlroots-proxy = pkgs.callPackage ./ei-wlroots-proxy.nix { };
            default = self.outputs.packages.${system}.ei-wlroots-proxy;
            devenv-up = self.devShells.${system}.default.config.procfileScript;
          };

          devShells.default = inputs.devenv.lib.mkShell {
            inherit inputs pkgs;
            modules = [
              ./devenv.nix
            ];
          };
        })
    // {
      overlays.default = final: prev: {
        inherit (self.packages.${final.system}) ei-wlroots-proxy;
      };
    };
}
