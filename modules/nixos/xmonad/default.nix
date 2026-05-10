{
  pkgs,
  ...
}: {
  config = {
    services.xserver = {
      enable = true;

      xkb = {
        layout = "us";
        variant = "";
      };

      displayManager.lightdm.enable = true;

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = haskellPackages: [
          haskellPackages.xmonad-contrib
          haskellPackages.xmonad-extras
          haskellPackages.xmonad
        ];
      };
    };

    # Make sure opengl is enabled
    hardware.graphics.enable = true;

    programs = {
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
      dconf.enable = true;
    };

    environment.systemPackages = with pkgs; [
      # xmonad essentials
      dmenu
      xmobar
      feh
      picom
      dunst
      xclip
      scrot
      arandr
      lxappearance
      nitrogen
      rofi
      alacritty
      xorg.xrandr
      xorg.xsetroot

      # File manager
      pcmanfm

      # Basic utilities
      networkmanagerapplet
      pavucontrol
      pasystray
    ];
  };
}
