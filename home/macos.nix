{ inputs
, outputs
, lib
, pkgs
, config
, packages
, ...
}: {
  imports = [
    outputs.homeManagerModules.zsh
    outputs.homeManagerModules.vscode
    outputs.homeManagerModules.nixpkgs
    outputs.homeManagerModules.firefox
    outputs.homeManagerModules.packages
    outputs.homeManagerModules.topgrade
  ];

  # This is required information for home-manager to do its job
  home = {
    stateVersion = "24.05";
    username = "akhmadiy";
    homeDirectory = "/Users/akhmadiy";

    # Tell it to map everything in the `config` directory in this
    # repository to the `.config` in my home-manager directory
    file.".config" = {
      source = ../configs/config;
      recursive = true;
    };

    file.".local/share" = {
      source = ../configs/share;
      recursive = true;
    };
  };

  # This is to ensure programs are using ~/.config rather than
  # /Users/sakhib/Library/whatever
  xdg.enable = true;

  # Let's enable home-manager
  programs.home-manager.enable = true;
}
