# Add your reusable NixOS modules to this directory, on their own file (https://wiki.nixos.org/ wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  ssh = import ./ssh;
  zsh = import ./zsh;
  boot = import ./boot;
  sound = import ./sound;
  users = import ./users;
  fonts = import ./fonts;
  desktop = import ./desktop;
  nixpkgs = import ./nixpkgs;
  hardware = import ./hardware;
}
