{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    package = pkgs.unstable.vscode;

    # Extentions
    extensions = with pkgs.vscode-extensions; [
      alefragnani.bookmarks
      davidanson.vscode-markdownlint
      editorconfig.editorconfig
      usernamehw.errorlens
      dbaeumer.vscode-eslint
      tamasfe.even-better-toml
      eamodio.gitlens
      jdinhlife.gruvbox
      haskell.haskell
      justusadam.language-haskell
      james-yu.latex-workshop
      bierner.markdown-mermaid
      pkief.material-icon-theme
      pkief.material-product-icons
      jnoortheen.nix-ide
      christian-kohler.path-intellisense
      esbenp.prettier-vscode
      rust-lang.rust-analyzer
      scalameta.metals
      scala-lang.scala
      timonwong.shellcheck
      vscodevim.vim
      wakatime.vscode-wakatime
      donjayamanne.githistory
      esbenp.prettier-vscode
      github.vscode-github-actions
      jebbs.plantuml
      mechatroner.rainbow-csv
      redhat.vscode-yaml
      pkief.material-icon-theme
      streetsidesoftware.code-spell-checker
      zhuangtongfa.material-theme
      ziglang.vscode-zig
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [ 
      {
          name = "lean4";
          publisher = "leanprover";
          version = "0.0.178";
          sha256 = "ByhiTGwlQgNkFf0BirO+QSDiXbQfR6RLQA8jM4B1+O4=";
        }
        {
          name = "markdown-checkbox";
          publisher = "bierner";
          version = "0.4.0";
          sha256 = "AoPcdN/67WOzarnF+GIx/nans38Jan8Z5D0StBWIbkk=";
        }
        {
          name = "markdown-preview-github-styles";
          publisher = "bierner";
          version = "2.0.3";
          sha256 = "yuF6TJSv0V2OvkBwqwAQKRcHCAXNL+NW8Q3s+dMFnLY=";
        }
        {
          name = "markdowntable";
          publisher = "takumii";
          version = "0.11.0";
          sha256 = "kn5aLRaxxacQMvtTp20IdTuiuc6xNU3QO2XbXnzSf7o=";
        }
    ];

    # User defined setings (raw json)
    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
  };
}
