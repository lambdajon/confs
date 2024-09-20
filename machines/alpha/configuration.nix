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
  
  networking.networkmanager.enable = true;

  time.timeZone = "Etc/GMT-5";
  i18n.defaultLocale = "en_US.UTF-8";

  services.displayManager = {
    sddm.enable = true;
  };
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
    };
    desktopManager = {
      plasma5.enable = true;
    };
    videoDrivers = [ "nvidia" ];
  };
  

  services.openssh.enable = true;
  services.pcscd.enable = true;
  services.printing.enable = true;
  services.earlyoom.enable = true;
  services.earlyoom.freeMemThreshold = 5;
  services.thermald.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
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
  ];

  environment.variables = {
    LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${pkgs.libGL}/lib";
  };

  programs.zsh.enable = true;

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
  };

  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };

  system.stateVersion = "24.05";
}