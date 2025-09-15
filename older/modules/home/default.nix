# Add your reusable home-manager modules to this directory, on their own file (https://wiki.nixos.org/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  zsh = import ./zsh;
  vscode = import ./vscode;
  xmobar = import ./xmobar;
  xmonad = import ./xmonad;
  firefox = import ./firefox;
  packages = import ./packages;
  topgrade = import ./topgrade;
  nixpkgs = import ../nixos/nixpkgs;
}
