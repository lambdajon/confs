{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    git = {
      isMacOS = lib.mkOption {
        type = lib.types.bool;
        default = pkgs.stdenv.hostPlatform.isDarwin;
        description = "Install MacOS specific agent.";
      };
    };
  };

  config = {
    # Git Configurations
    programs.git = {
      enable = true;
      lfs.enable = true;

      # User credentials
      userName = "lambdajon";
      userEmail = "lambdajon42@gmail.com";

      extraConfig = {
        http.sslVerify = false;
        pull.rebase = false;
      };

      # Aliases
      aliases = {
        ch = "checkout";
      };

      # Git ignores
      ignores = [
        ".idea"
        ".DS_Store"
        "nohup.out"
      ];
    };
  };
}
