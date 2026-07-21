{
  lib,
  inputs,
  outputs,
  ...
}: {
  config = {
    system.primaryUser = "lambdajon";

    # Available users in the machine
    users.users = {
      lambdajon = {
        home = "/Users/lambdajon";

        openssh.authorizedKeys.keys = lib.strings.splitString "\n" (
          builtins.readFile (
            builtins.fetchurl {
              url = "https://github.com/lambdajon.keys";
              sha256 = "14c87239fcdd80f4f6a3dfd2683e437d321022f32ac09cf40a404626c25e9673";
            }
          )
        );
      };
    };

    # Home manager configuration for users
    home-manager = {
      extraSpecialArgs = {
        inherit inputs outputs;
      };
      backupFileExtension = "baka";
      users = {
        # Import your home-manager configuration
        lambdajon = import ../../../home.nix;
      };
    };
  };
}
