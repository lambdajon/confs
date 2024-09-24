{ config, pkgs, ... }: {
  config = {
    # Ucode && microcode
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    # Enable thermal management
    services.thermald.enable = true;
  };
}
