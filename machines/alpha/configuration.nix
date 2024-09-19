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
  i18n.defaultLocale = "en_Us.UTF-8";
  i18n.extraLocaleSettings = {
    LANGUAGE = "en_Us";
    LC_ALL = "en_Us.UTF-8";
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      # options = "caps:escape,grp:alt_shift_toggle";
      # variant = "altgr-intl";
    };
    displayManager = {
      sddm.enable = true;
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
    git
  ];

  environment.variables = {
    LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${pkgs.libGL}/lib";
  };

  programs.zsh.enable = true;

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    nvidiaSettings = false;
    powerManagement.enable = true;
  };
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };

  system.stateVersion = "23.05";
}