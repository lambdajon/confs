{ pkgs ? let
    # Use packages indicated in lock file to match version
    lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in
  import nixpkgs { overlays = [ ]; }
, ...
}: pkgs.stdenv.mkDerivation {
  name = "shell";

  nativeBuildInputs = with pkgs; [
    # Devops stuff
    sops
    age

    # LSPs
    nil
    nixd
    yamllint

    # Uncomment if your Nix version is old
    # nix

    # Formatter
    nixpkgs-fmt

    # SVCs
    git
  ];

  # Cancer
  buildInputs = with pkgs.python3Packages; [
    python
    requests
    opencv4
  ];

  NIX_CONFIG = "extra-experimental-features = nix-command flakes";
}
