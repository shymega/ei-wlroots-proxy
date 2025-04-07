# SPDX-FileCopyrightText: 2024 The Input Leap Developers
# SPDX-FileCopyrightText: 2024 The ei-wlroots-proxy Developers
# SPDX-FileCopyrightText: 2025 Dom Rodriguez
#
# SPDX-License-Identifier: Apache-2.0

{ lib
, rustPlatform
, pkg-config
, wayland-protocols
, wayland
, stdenv
}:
let
  pname = "ei-wlroots-proxy";
  version = "unstable";

  src = lib.cleanSource ../../.;
in
rustPlatform.buildRustPackage {
  inherit version src pname;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    rustPlatform.bindgenHook
  ] ++ lib.optional stdenv.isLinux [
    wayland
    wayland-protocols
  ];

  meta = with lib; {
    description = "";
    homepage = "https://input-leap.github.io";
    license = licenses.asl20;
    maintainers = with maintainers; [ shymega ];
    mainProgram = "ei-wlroots-proxy";
  };
}
