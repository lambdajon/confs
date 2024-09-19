{ pkgs, lib, ... }:
let
  inherit (lib.hm.gvariant) mkTuple mkUint32;
in
{
  home.stateVersion = "24.05";

  home.file.".ghci".source = ../../.config/.ghci;
  home.file.".npmrc".source = ../../.config/.npmrc;

  home.sessionPath = [
    "$HOME/.npm-global/bin"
    "$HOME/.local/bin"
  ];

  programs.zoxide.enable = true;
  programs.bash.enable = true;
  programs.git = {
    enable = true;
    lfs.enable = true;
    difftastic.enable = true;
  };
  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };
  programs.sbt.enable = true;
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [{
      name = "vi-mode";
      src = pkgs.zsh-vi-mode;
      file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
    }];

    history = {
      extended = true;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };

    shellAliases = {
      ydl = "yt-dlp -o '%(title)s.%(ext)s' -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'";
      adl = "yt-dlp -o '%(title)s.%(ext)s' -f 'bestaudio[ext=m4a]/best' --extract-audio";
    };
  };
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        clearurls
        darkreader
        # dont-accept-image-webp
        # imagus
        i-dont-care-about-cookies
        privacy-badger
        simple-tab-groups
        single-file
        ublock-origin
        unpaywall
        vimium
        youtube-shorts-block
        # user-agent-switcher-manager
      ];
      settings = {
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.search.suggest.enabled" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "browser.urlbar.suggest.searches" = false;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "font.name.monospace.x-western" = "SF Mono";
        "font.name.sans-serif.x-western" = "SF Pro Display";
        "signon.autofillForms" = false;
        "signon.firefoxRelay.feature" = "disabled";
        "signon.generation.enabled" = false;
        "signon.management.page.breach-alerts.enabled" = false;
        "signon.rememberSignons" = false;
      };
    };
  };
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    package = pkgs.vscode;
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
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      
    ];
    userSettings = builtins.fromJSON (builtins.readFile ../../.config/code/settings.json);
  };

  home.packages = with pkgs; [
    telegram-desktop
    zulip
    zulip-term
    discord
    keepassxc
    stacer
    qbittorrent
    openvpn
    baobab
    smartmontools
    flameshot
    libqalculate
    nfs-utils
    zoom-us
    # CLI
    difftastic
    fzf
    htop
    jq
    pfetch
    rename
    ripgrep
    rlwrap
    solaar
    spek
    tmux
    tokei
    tree
    insomnia
    notes
    newsboat
    nb
    texlive.combined.scheme-medium
    hugo
    # Media
    moc
    ffmpeg-full
    mpv
    yt-dlp
    feh
    imagemagick
    obs-studio
    optipng
    peek
    krita
    # Database
    sqlite
    # BQN
    cbqn
    # C
    gcc
    gdb
    llvmPackages_16.clang-unwrapped
    # Haskell
    # haskell.compiler.ghc910
    cabal-install
    ghc
    pckgconfig
    # (haskell-language-server.override { supportedGhcVersions = [ "910" ]; supportedFormatters = [ "fourmolu" ]; })
    haskellPackages.cabal-fmt
    haskellPackages.fourmolu
    haskellPackages.hlint
    haskellPackages.ghcprofview
    # Java
    maven
    # Nix
    nil
    nixd
    nixpkgs-fmt
    # Lean
    elan
    # Rust
    rustup
    # Scala
    metals
  ];
}