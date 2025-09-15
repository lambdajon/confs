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
        # L's to motherfuckers from discord
        # for not supporting arm64
        discord
      ]);

  # General packages
  any-pkgs = (with pkgs;[
    telegram-desktop
    zulip
    spotify
    qbittorrent
    openvpn
    zoom-us
    obs-studio
    krita
    mpv
    insomnia
  ]) ++ (with pkgs.unstable; [
    zed-editor
  ]);
in
{
  config = {
    users.users = {
      lambdajon = {
        isNormalUser = true;
        description = "Lambdajon";
        initialPassword = "https://cornhub.website";
        openssh.authorizedKeys.keys = [ "" ]; # TODO: Add ssh pub key here
        extraGroups = [ "networkmanager" "wheel" "docker" "vboxusers" ];
        packages = any-pkgs ++ arm-incs;
      };
    };

    home-manager = {
      extraSpecialArgs = { inherit inputs outputs; };
      users = {
        # Import your home-manager configuration
        lambdajon = import ../../../home/linux.nix;
      };
    };
  };
}
