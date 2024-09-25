{ config, lib, ... }: {
  config = {
    # Ucode && microcode
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    # Kernel modules for intel
    boot.kernelModules = [ "kvm-intel" ];

    # Enable thermal management
    services.thermald.enable = true;
  };
}
