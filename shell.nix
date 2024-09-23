{ pkgs ? import <nixpkgs> {}, ... } : {
  default = pkgs.mkShell = {
    name = "lambdashell";

    nativeBuildInputs = with pkgs; [
      sops
      age
      yamllint


    ];

    buildInputs = with pkgs.python3Packages; [
      python
      requests
      opencv4
    ];

    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
  };
  
}
