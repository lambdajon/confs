{
  pkgs,
  inputs,
  outputs,
  ...
}: let
  inherit (inputs.self) lib;

  # Packages that are not aarch64 compatible
  x86_64-only =
    lib.condition.mkArrIf
    pkgs.stdenv.hostPlatform.isx86_64
    (with pkgs; [
      # Latest discord
      pkgs.discord
      # To patch discord's krisp
      pkgs.krisper
      # Zoom conference
      zoom-us
    ]);

  packages =
    (with pkgs; [
      # Matrix client
      fractal
      # Mastodon client
      tuba
      # Telegram desktop
      unstable.telegram-desktop
      # GitHub Desktop
      github-desktop
      # RDP Management
      remmina
    ])
    ++ x86_64-only;

  hashedPassword = lib.strings.concatStrings [
    "$y$j9T$Mz/8a3eFGN0Iadkgh0Bi80$9DapI4"
    "ju56c1wAo4kgEl24J99Uqulbsk19TOOv1NRm7"
  ];
in {
  config = {
    users.users = {
      sakhib = {
        inherit packages hashedPassword;
        isNormalUser = true;
        description = "Lambdajon";

        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
          "vboxusers"
          "media"
          "admins"
          "libvirtd"
        ];

        openssh.authorizedKeys.keys = lib.strings.splitString "\n" (
          builtins.readFile (
            builtins.fetchurl {
              url = "https://github.com/lambdajon.keys";
              sha256 = "440dac32fb3ecd060c17f78ad7c34422fefaaccf525c75c3c8dfd5ce86ef516e";
            }
          )
        );
      };
    };

    home-manager = {
      backupFileExtension = "baka";
      extraSpecialArgs = {
        inherit inputs outputs;
      };
      users = {
        # Import your home-manager configuration
        lambdajon = import ../../../home.nix;
      };
    };
  };
}