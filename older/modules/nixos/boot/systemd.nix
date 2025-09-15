{ pkgs, ... }: {
  config = {
    # Bootloader.
    boot = {
      # Actual loader configs
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
      };
    };
  };
}
