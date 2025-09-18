#!/usr/bin/env just --working-directory ./ --justfile

default:
  @just --list

#     _   ___      ____  _____
#    / | / (_)  __/ __ \/ ___/
#   /  |/ / / |/_/ / / /\__ \
#  / /|  / />  </ /_/ /___/ /
# /_/ |_/_/_/|_|\____//____/

nx-update-local:
    sudo nixos-rebuild switch --flake . --upgrade

nx-update-repo:
    sudo nixos-rebuild switch --flake github:lambdajon/confs --upgrade

#   ______            __
#  /_  __/___  ____  / /____
#   / / / __ \/ __ \/ / ___/
#  / / / /_/ / /_/ / (__  )
# /_/  \____/\____/_/____/

repl:
  export NIXPKGS_ALLOW_UNFREE=1 && nix repl -f ./repl.nix --impure

format:
    nix fmt

test:
    nix flake check --all-systems --show-trace

build-darwin:
  nix build .#darwinConfigurations.Lambdajons-MacBook-Pro.config.system.build.toplevel --show-trace

build-nixos:
  echo "welcome nixos"
  # nix build .#nixosConfigurations.Laboratory.config.system.build.toplevel --show-trace

switch-darwin: 
  sudo nix run nix-darwin -- switch --flake .#Lambdajons-MacBook-Pro --show-trace
