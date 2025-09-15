# ==================
# README BITCH!!!
# ==================
# Keep only cli things here, move macos only things to ./osx.nix
# Linux only related things to ./linux.nix. This file keeps
# whatever supported by both.
#
# If you want to add something gui, do this via homebrew on mac,
# on NixOS, add GUI app at modules/nixos/users/<user>.nix
{ pkgs, ... }: with pkgs; [
  zulip-term
  keepassxc
  stacer
  baobab
  smartmontools
  flameshot
  libqalculate
  nfs-utils

  # Cli
  difftastic
  fzf
  htop
  jq
  pfetch
  rename
  ripgrep
  rlwrap
  solaar
  spek
  tmux
  tokei
  tree
  notes
  newsboat
  nb
  texlive.combined.scheme-medium
  hugo

  # Media
  moc
  ffmpeg-full

  yt-dlp
  feh
  imagemagick
  optipng
  peek


  # Database
  sqlite

  # BQN
  cbqn

  # C
  gcc
  gdb
  llvmPackages_16.clang-unwrapped

  # Haskell
  haskell.compiler.ghc98
  cabal-install
  (haskell-language-server.override { supportedGhcVersions = [ "98" ]; supportedFormatters = [ "fourmolu" ]; })
  haskellPackages.cabal-fmt
  haskellPackages.fourmolu
  haskellPackages.hlint
  haskellPackages.ghcprofview

  # Java
  maven

  # Nix
  nil
  nixd
  nixpkgs-fmt

  # Lean
  elan

  # Rust
  rustup

  # Scala
  metals
]
