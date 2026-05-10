{
  pkgs,
  lib,
  ...
}: let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
in {
  config = lib.mkIf isLinux {
    xsession.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./xmonad.hs;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmobar
      ];
    };

    # xmobar configuration
    home.file.".xmobarrc".source = ./xmobarrc;

    # Picom compositor config
    services.picom = {
      enable = true;
      fade = true;
      shadow = true;
      fadeDelta = 4;
      shadowOpacity = 0.5;
      settings = {
        corner-radius = 8;
      };
    };

    # Dunst notifications
    services.dunst = {
      enable = true;
      settings = {
        global = {
          font = "JetBrainsMono Nerd Font 10";
          frame_width = 2;
          frame_color = "#458588";
          corner_radius = 8;
        };
        urgency_low = {
          background = "#282828";
          foreground = "#ebdbb2";
          timeout = 5;
        };
        urgency_normal = {
          background = "#282828";
          foreground = "#ebdbb2";
          timeout = 10;
        };
        urgency_critical = {
          background = "#cc241d";
          foreground = "#ebdbb2";
          timeout = 0;
        };
      };
    };

    # Rofi launcher
    programs.rofi = {
      enable = true;
      theme = "gruvbox-dark";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      extraConfig = {
        modi = "drun,run,window";
        show-icons = true;
      };
    };

    # Alacritty terminal
    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          normal.family = "JetBrainsMono Nerd Font";
          size = 11;
        };
        window = {
          padding = {
            x = 8;
            y = 8;
          };
          opacity = 0.95;
        };
        colors = {
          primary = {
            background = "#282828";
            foreground = "#ebdbb2";
          };
        };
      };
    };
  };
}
