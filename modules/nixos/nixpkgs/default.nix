{
  lib,
  config,
  inputs,
  ...
}: {
  config = {
    nixpkgs = {
      # You can add overlays here
      overlays = [
        # Add overlays your own flake exports (from overlays and pkgs dir):
        inputs.orzklv-pkgs.overlays.unstable
        inputs.orzklv-pkgs.overlays.additions
        inputs.orzklv-pkgs.overlays.modifications

        # You can also add overlays exported from other flakes:
        # neovim-nightly-overlay.overlays.default

        # Or define it inline, for example:
        # (final: prev: {
        #   hi = final.hello.overrideAttrs (oldAttrs: {
        #     patches = [ ./change-hello-to-hi.patch ];
        #   });
        # })
      ];
      # Configure your nixpkgs instance
      config = {
        # Disable if you don't want unfree packages
        allowUnfree = true;
        # Disable if you don't want linux thingies on mac
        allowUnsupportedSystem = true;
        # Workaround for https://github.com/nix-community/home-manager/issues/2942
        allowUnfreePredicate = _: true;
        # Let the system use fucked up programs
        allowBroken = true;
      };
    };

    nix = {
      # This will add each flake input as a registry
      # To make nix3 commands consistent with your flake
      # registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

      # This will additionally add your inputs to the system's legacy channels
      # Making legacy nix commands consistent as well, awesome!
      nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

      settings = {
        sandbox = true;
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes pipe-operators";
        # Trusted users for secret-key
        trusted-users = [
          "${config.users.users.lambdajon.name}"
        ];


        allow-import-from-derivation = true;

        trusted-public-keys = [
          "hackage-server.cachix.org-1:iw0iRh6+gsFIrxROFaAt5gKNgIHejKjIfyRdbpPYevY="
          "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
          "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        ];
        # Trusted users for secret-key
        substituters = [
          "https://hackage-server.cachix.org/"
          "https://cache.iog.io"
          "https://cache.garnix.io"
        ];
      };
      
    };
  };
}
