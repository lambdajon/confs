{ inputs, outputs, lib, pkgs, hostname, username, ... }: {
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
    "nvidia.NVreg_RegistryDwords=EnableBrightnessControl=1"
  ];
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = hostname;
  
  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      support32Bit = true;
    };

    nvidia = {
      open = false;
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      nvidiaSettings = true;
    };

    bluetooth = {
      settings = {
        General = {
          Experimental = true;
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };
  

  networking.networkmanager.enable = true;

  time.timeZone = "Etc/GMT-5";
  i18n.defaultLocale = "en_US.UTF-8";


  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
    };
    desktopManager = {
      plasma6.enable = true;
    };
    videoDrivers = [ "nvidia" ];
  };

  services.desktopManager = {
    plasma6.enable = true;
  };
  
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  # services.displayManager.plasma6.enable = true;

  services.openssh.enable = true;
  services.pcscd.enable = true;
  services.printing.enable = true;
  services.earlyoom.enable = true;
  services.earlyoom.freeMemThreshold = 5;
  services.thermald.enable = true;

  
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    audio.enable = true;

  };

  users.defaultUserShell = pkgs.zsh;
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  virtualisation.docker.enable = true;
  environment.shells = with pkgs; [ zsh ];
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
  ];

  environment.variables = {
    LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${pkgs.libGL}/lib";
  };

  programs.zsh.enable = true;

  system.stateVersion = "24.05";
}