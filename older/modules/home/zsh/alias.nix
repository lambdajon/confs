{ pkgs, lib, ... }:
let
  determinateSystems = "curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix";
  isMacOS = pkgs.stdenv.hostPlatform.system == "aarch64-darwin" || pkgs.stdenv.hostPlatform.system == "x86_64-darwin";

  mac = lib.mkIf isMacOS {
    # Refresh
    clean = "nix store gc";
  };

  linux = lib.mkIf (!isMacOS) {
    # Refresh
    clean = "nix store gc && nix collect-garbage -d";
  };

  default = {
    # General aliases
    neofetch = "fastfetch";
    ssh-hosts = "grep -P \"^Host ([^*]+)$\" $HOME/.ssh/config | sed 's/Host //'";
    ydl = "yt-dlp -o '%(title)s.%(ext)s' -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'";
    adl = "yt-dlp -o '%(title)s.%(ext)s' -f 'bestaudio[ext=m4a]/best' --extract-audio";

    # Refresh
    refresh = "source ~/.zshrc";

    # Updating system
    update = "nix store gc && topgrade";
    nix-shell = "nix-shell --run zsh";
    nix-develop = "nix develop -c \"$SHELL\"";
    determinate = "${determinateSystems} | sh -s -- ";
    repair = "${determinateSystems} | sh -s -- repair";
  };

  cfg = lib.mkMerge [
    mac
    linux
    default
  ];
in
{
  config = {
    programs.zsh.shellAliases = cfg;
  };
}
