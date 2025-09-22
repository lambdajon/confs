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
              sha256 = "440dac32fb3ecd060c17f78ad7c34422fefaaccf525c75c3c8dfd5ce86ef516e";
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
