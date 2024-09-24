{ pkgs
, inputs
, outputs
, lib
, config
, packages
, ...
}:
let
  # If unstable packages are needed, add to pkgs list
  # ++ (with pkgs.unstable; [ ])

  # Packages that aren't available on aarch64
  arm-incs =
    if (pkgs.stdenv.hostPlatform.isAarch64)
    then [ ]
    else
      (with pkgs;[
        discord
      ]);

  # General packages
  any-pkgs = (with pkgs;[
    telegram-desktop
    github-desktop
    spotify
  ]) ++ (with pkgs.unstable; [
    zed-editor
  ]);
in
{
  config = {
    users.users = {
      sakhib = {
        isNormalUser = true;
        description = "Lambdajon";
        initialPassword = "HaHaLambdaG0Brrrrr...";
        openssh.authorizedKeys.keys = [ "" ];
        extraGroups = [ "networkmanager" "wheel" "docker" "vboxusers" ];
        packages = any-pkgs ++ arm-incs;
      };
    };

    home-manager = {
      extraSpecialArgs = { inherit inputs outputs; };
      users = {
        # Import your home-manager configuration
        sakhib = import ../../../home/linux.nix;
      };
    };
  };
}
