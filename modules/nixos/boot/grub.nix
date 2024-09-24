{ pkgs, ... }: {
  config = {
    # Bootloader.
    boot = {
      # Shut the fuck up
      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];

      # Actual loader configs
      loader = {
        efi.canTouchEfiVariables = true;
        grub = {
          enable = true;
          devices = [ "nodev" ];
          efiSupport = true;
          useOSProber = true;
          theme = pkgs.stdenv.mkDerivation {
            pname = "hyperfluent-grub-theme";
            version = "1.0.1";
            src = pkgs.fetchFromGitHub {
              owner = "Coopydood";
              repo = "HyperFluent-GRUB-Theme";
              rev = "v1.0.1";
              hash = "sha256-zryQsvue+YKGV681Uy6GqnDMxGUAEfmSJEKCoIuu2z8=";
            };
            installPhase = "cp -r $src/nixos $out";
          };
        };
      };

      # Animated loading yeeee...
      plymouth = {
        enable = true;
        theme = "breeze";
      };
    };
  };
}
