{pkgs, ...}: [
  # Downloader
  pkgs.aria2
  pkgs.yt-dlp

  # Developer Mode
  pkgs.gh
  pkgs.jq
  pkgs.wget
  pkgs.gitui
  pkgs.netcat
  pkgs.direnv
  pkgs.git-lfs
  # pkgs.cargo-update
  # pkgs.nixvim

  # Environment
  pkgs.fd
  pkgs.bat
  pkgs.btop
  pkgs.eza
  pkgs.figlet
  pkgs.gping
  pkgs.hyperfine
  pkgs.onefetch
  pkgs.procs
  pkgs.ripgrep
  pkgs.tealdeer
  pkgs.topgrade

  # For Prismlauncher
  pkgs.jdk17

  # Media encode & decode
  pkgs.ffmpeg-full
  pkgs.libheif

  # GPG Signing
  pkgs.gnupg

  # Database
  pkgs.sqlite

  # Lean
  pkgs.elan
  # Agda
  (pkgs.agda.withPackages (ps:
    with ps; [
      standard-library
    ]))
  # Alloy
  pkgs.alloy6

  # Rust
  pkgs.rustc
  pkgs.cargo
  pkgs.clippy
  pkgs.rust-analyzer
  pkgs.rustfmt
  # C
  pkgs.gcc
  pkgs.gdb
  pkgs.llvmPackages_20.clang-unwrapped
  pkgs.llvmPackages_20.libllvm
  #Z3
  pkgs.z3

  # Nodejs
  pkgs.nodejs_24

  # net tools
  pkgs.nmap
  # pkgs.dbus

  #uml

  pkgs.graphviz

]
