{ inputs, outputs, lib, pkgs, hostname, username, ... }: {
  # You can import other NixOS modules here
  imports =
    [
      # If you want to use modules your own flake exports (from modules/nixos):
      outputs.nixosModules.ssh
      outputs.nixosModules.zsh
      outputs.nixosModules.nixpkgs
      outputs.nixosModules.desktop.kde
      outputs.nixosModules.hardware.intel
      outputs.nixosModules.hardware.nvidia

      # Or modules from other flakes (such as nixos-hardware):
      # inputs.hardware.nixosModules.common-cpu-amd
      # inputs.hardware.nixosModules.common-ssd

      # You can also split up your configuration and import pieces of it here:
      # ./users.nix

      # Import your generated (nixos-generate-config) hardware configuration
      ./hardware-configuration.nix

      # Home Manager NixOS Module
      inputs.home-manager.nixosModules.home-manager
    ];

  # Enable networking
  # Warning! Your hostname must be same as the key in nixosConfigurations
  networking.hostName = "Alpha"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  # Set your time zone.
  time.timeZone = "Asia/Tashkent";
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Don't ask for sudo password
  security.sudo.wheelNeedsPassword = false;

  # Smart card reader daemon
  services.pcscd.enable = true;

  # Early OOM management
  services.earlyoom.enable = true;
  services.earlyoom.freeMemThreshold = 5;

  environment.systemPackages = with pkgs; [
    docker-compose
    file
    vim
    wget
    xclip
    lsof
    strace
    zip
    unzip
    fdupes
    libGL
    pulseaudio
    usbutils
    pciutils
    git
    #
    inxi
    kdePackages.kdeconnect-kde
    kdePackages.plasma-browser-integration
    openssl
    vulkan-tools
    wayland-utils
    wineWowPackages.waylandFull
    xwaylandvideobridge
    curl
  ];

  environment.variables = {
    LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${pkgs.libGL}/lib";
  };

  # Enabling docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
