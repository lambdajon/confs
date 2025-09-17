{
  lib,
  config,
  ...
}: let
  apps = lib.mkIf config.homebrew.enable {
    "Playgrounds" = 1496833156;
    "RunCat" = 1429033973;
    "TestFlight" = 899247664;
    "Pages" = 409201541;
    "Telegram" = 747648890;
    "iMovie" = 408981434;
    "Numbers" = 409203825;
    "Keynote" = 409183694;
    "Shazam" = 897118787;
  };
in {
  # AppStore installations
  homebrew.masApps = apps;
}
