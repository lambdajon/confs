{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    package = pkgs.vscode;

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
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [ ];

    # User defined setings (raw json)
    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
  };
}
