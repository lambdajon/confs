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
              sha256 = "5d4939839fb6eddf632975d6dbb61b2d58e6c6d832dc8bf49066e10772191e40";
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
      users = {
        # Import your home-manager configuration
        lambdajon = import ../../../home.nix;
      };
    };
  };
}
