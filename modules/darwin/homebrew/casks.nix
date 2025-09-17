{
  lib,
  config,
  ...
}: let
  apps = lib.mkIf config.homebrew.enable [
    "discord"
    "element"
    "font-sf-mono-nerd-font-ligaturized"
    "github"
    "iterm2"
    "keka"
    "kekaexternalhelper"
    "logitech-options"
    "macs-fan-control"
    "obs"
    "sf-symbols"
    "telegram-desktop"
    "zen"
  ];
in {
  # Homebrew Casks installations
  homebrew.casks = apps;
}
