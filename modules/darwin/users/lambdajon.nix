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
              sha256 = "f26939f06d4020651078e49df8f63a9880babf5bdf4a9b6153d61359daf5f8e6";
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
