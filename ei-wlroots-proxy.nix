# SPDX-FileCopyrightText: 2024 The Input Leap Developers
#
# SPDX-License-Identifier: Apache-2.0

{ lib
, pkgs ? import <nixpkgs>
, rustPlatform
,
}:
rustPlatform.buildRustPackage {
  name = "ei-wlroots-proxy";

  src = lib.cleanSource ./.;

  cargoLock = {
    lockFile = ./Cargo.lock;
    allowBuiltinFetchGit = false;
  };

  nativeBuildInputs = with pkgs; [ pkg-config ];
  buildInputs = with pkgs; [ systemd.dev ];

  meta = with lib; {
    description = "";
    homepage = "https://github.com/input-leap/ei-wlroots-proxy";
    license = licenses.asl20;
  };
}
