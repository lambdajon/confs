{ config
, pkgs
, lib
, ...
}:
{
  config = {
    programs.xmobar = {
      enable = true;
      extraConfig = builtins.readFile ./xmobarrc;
    };
  };
}
