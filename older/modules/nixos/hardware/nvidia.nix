{ config, pkgs, ... }: {
  config = {
    # Implement for xserver
    services.xserver.videoDrivers = [ "nvidia" ];

    # GPU for docker containers
    hardware.nvidia-container-toolkit.enable = true;

    # Kernel mod for nvidia laptops
    boot.kernelParams = [
      "nvidia.NVreg_RegistryDwords=EnableBrightnessControl=1"
    ];

    # Driver + parameters
    hardware.nvidia = {
      open = false;
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
