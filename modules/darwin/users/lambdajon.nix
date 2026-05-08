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
              sha256 = "91326cec646e76dfd3af79035f7254085b57319d91720d15b9f6caa853a0e554";
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
