# SPDX-FileCopyrightText: 2024 The Input Leap Team
# SPDX-FileCopyrightText: 2024 The ei-wlroots-proxy Developers
#
# SPDX-License-Identifier: Apache-2.0
# SPDX-License-Identifier: GPL-3.0-or-later

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
        devShells.default = pkgs.buildFHSUserEnv {
          name = "ei-wlroots-proxy-dev";
          targetPkgs = pkgs: with pkgs; [
            bun
            cabextract
            cairo
            cargo
            cargo-tauri
            clippy
            cmake
            gcc
            git
            glibc
            gtk3
            openssl
            pkg-config
            python3Packages.aiohttp
            python3Packages.pipx
            python3Packages.toml
            rustc
            rustfmt
            rustup
          ] ++ [ self.packages.${system}.ei-wlroots-proxy ];
        };
      }) // {
      overlays.default = final: prev: {
        inherit (self.packages.${final.system}) ei-wlroots-proxy;
      };
    };
}
