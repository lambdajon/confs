{ config
, pkgs
, lib
, ...
}:
let
  # xmonad = pkgs.xmonad-with-packages.override {
  #   packages = self: [ self.xmonad-contrib ];
  # };
in
{
  config = {
    xsession = {
      enable = true;

      windowManager = {
        # command = "${xmonad}/bin/xmonad";
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
          config = pkgs.writeText "xmonad.hs" (builtins.readFile ./xmonad.hs);
        };
      };
    };
  };
}
