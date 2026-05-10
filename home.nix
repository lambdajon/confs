{
  inputs,
  outputs,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs) stdenv;
  osx = stdenv.hostPlatform.isDarwin;

  modules = [
    outputs.homeModules.zsh
    outputs.homeModules.git
    # outputs.homeModules.ssh
    # outputs.homeModules.zed
    # outputs.homeModules.helix
    # outputs.homeModules.secret
    outputs.homeModules.nixpkgs
    outputs.homeModules.topgrade
    outputs.homeModules.packages
    outputs.homeModules.fastfetch
    outputs.homeModules.vscode
    outputs.homeModules.haskell
    # outputs.homeModules.emacs
    outputs.homeModules.xmonad

    # Third party modules
    # inputs.zen-browser.homeModules.twilight
  ];

  home =
    if osx
    then "Users"
    else "home";

  macos = lib.mkIf osx {
    # Leave here configs that should be applied only at macos machines

    # This is to ensure programs are using ~/.config rather than
    # /Users/lambdajon/Library/whatever
    xdg.enable = true;
  };

  cfg = {
    # This is required information for home-manager to do its job
    home = {
      stateVersion = "24.11";
      username = "lambdajon";
      homeDirectory = "/${home}/lambdajon";
      enableNixpkgsReleaseCheck = false;

      # Tell it to map everything in the `config` directory in this
      # repository to the `.config` in my home-manager directory
      # file.".local/share/fastfetch" = {
      #   source = ./configs/fastfetch;
      #   recursive = true;
      # };
    };

    # Let's enable home-manager
    programs.home-manager.enable = true;
  };
in {
  imports = modules;

  config =
    lib.mkMerge
    [
      cfg
      macos
    ];
}
