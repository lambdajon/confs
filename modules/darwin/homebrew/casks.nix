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
    "orbstack"
    "sf-symbols"
    "telegram-desktop"
    "visual-studio-code"
    "zen"
  ];
in {
  # Homebrew Casks installations
  homebrew.casks = apps;
}
