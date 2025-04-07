# SPDX-FileCopyrightText: 2024 The Input Leap Developers
# SPDX-FileCopyrightText: 2025 Dom Rodriguez
#
# SPDX-License-Identifier: Apache-2.0

{
  languages = {
    nix.enable = true;
    rust.enable = true;
    shell.enable = true;
  };
  devcontainer.enable = true;
  difftastic.enable = true;
  pre-commit.hooks = {
    rustfmt.enable = true;
    clippy.enable = true;
    clippy.settings.offline = false;
    shellcheck.enable = true;
    shfmt.enable = true;
    actionlint.enable = true;
    nixpkgs-fmt.enable = true;
    markdownlint.enable = true;
    statix.enable = true;
  };
}
