# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  outputs,
  config,
  pkgs,
  ...
}:let relago = inputs.relago.packages.x86_64-linux.default; in {
  
  imports = [
    outputs.nixosModules.zsh
    outputs.nixosModules.ssh
    outputs.nixosModules.desktop
    outputs.nixosModules.nixpkgs
    outputs.nixosModules.boot.systemd
    outputs.nixosModules.users.lambdajon
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.crash.nixosModules.c-segfault
    inputs.relagoServer.nixosModules.server
    inputs.relago.nixosModules.default

    inputs.home-manager.nixosModules.home-manager
    inputs.nix-data.nixosModules.nix-data
  ];

  programs.nix-data = {
    enable = true;
    systemconfig = "/home/lambdajon/confs/nixos/tower2/configuration.nix";
    flake = "/home/lambdajon/confs/flake.nix";
    flakearg = "nixos"; # your hostname 
  };
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # services.xinux-c-segfault.enable = true;
  
  services.relago = {enable = true; nix-config = "/home/lambdajon/confs";};

  hardware = {
    graphics = {
      enable = true;
    };

    nvidia = {
      # enable = true;
      open = true;
      modesetting.enable = true;
      nvidiaSettings = true;
      powerManagement.enable = true;
    };

    bluetooth.settings = {
      General = {
        Experimental = true;
      };
    };
  };

  
  
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tashkent";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.lambdajon = {
  #   isNormalUser = true;
  #   description = "lambdajon";
  #   extraGroups = ["networkmanager" "wheel"];
  #   packages = with pkgs; [
  #     #  thunderbird
  #   ];
  # };


  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    docker-compose
    docker
    relago
  ];
  virtualisation.docker.enable = true;

  system.stateVersion = "25.11"; # Did you read the comment?
}
