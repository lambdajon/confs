{ pkgs, ... }: {
  imports = [
    ./alias.nix
  ];

  # I use zsh, but bash and fish work just as well here. This will setup
  # the shell to use home-manager properly on startup, neat!
  programs.zsh = {
    # Install zsh
    enable = true;

    # ZSH Autosuggestions
    # The option `programs.zsh.enableAutosuggestions' defined in config
    # has been renamed to `programs.zsh.autosuggestion.enable'.
    autosuggestion.enable = true;

    # ZSH Completions
    enableCompletion = true;

    # ZSH Syntax Highlighting
    syntaxHighlighting.enable = true;

    # Third party plugins to be installed
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
      {
        name = "vi-mode";
        file = "zsh-vi-mode.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "jeffreytse";
          repo = "zsh-vi-mode";
          rev = "v0.11.0";
          sha256 = "0bs5p6p5846hcgf3rb234yzq87rfjs18gfha9w0y0nf5jif23dy5";
        };
      }
    ];

    # More history logs
    history = {
      extended = true;
    };

    # Oh my zsh integration
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
}
