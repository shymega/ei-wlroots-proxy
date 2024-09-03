# SPDX-FileCopyrightText: 2024 The Input Leap Developers
# SPDX-FileCopyrightText: 2024 The ei-wlroots-proxy Developers
#
# SPDX-License-Identifier: Apache-2.0
# SPDX-License-Identifier: Apache-2.0

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs =
    { self
    , ...
    }@inputs:
    inputs.flake-utils.lib.eachDefaultSystem
      (system:
      let
        pkgs = inputs.nixpkgs.outputs.legacyPackages.${system};
      in
      {
        packages.ei-wlroots-proxy = pkgs.callPackage ./build-aux/nix { };
        packages.default = self.outputs.packages.${system}.ei-wlroots-proxy;
        devShells.default = pkgs.mkShell {
          name = "ei-wlroots-proxy-dev";
          inputsFrom = [ self.packages.${system}.ei-wlroots-proxy ];
        };
      }) // {
      overlays.default = final: prev: {
        inherit (self.packages.${final.system}) ei-wlroots-proxy;
      };
    };
}
