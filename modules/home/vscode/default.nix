{pkgs, ...}: {
  config = {
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
        # wakatime.vscode-wakatime
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
      ];

      # User defined setings (raw json)
      userSettings = {
        "workbench.colorTheme" = "Gruvbox Dark Medium";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.productIconTheme" = "material-product-icons";
        "window.nativeTabs" = true;
        "files.autoSave" = "afterDelay";
        "redhat.telemetry.enabled" = true;
        "[typescript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[yaml]" = {
          "editor.defaultFormatter" = "redhat.vscode-yaml";
        };
        "editor.tabSize" = 2;
        "[json]" = {
          "editor.defaultFormatter" = "vscode.json-language-features";
        };
        "[javascript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "files.watcherExclude" = {
          "**/.bloop" = true;
          "**/.metals" = true;
          "**/.ammonite" = true;
        };
        "[markdown]" = {
          "editor.wordWrap" = "wordWrapColumn";
          "editor.wrappingIndent" = "same";
          "editor.wordWrapColumn" = 120;
          "vim.textwidth" = 120;
        };
        "haskell.manageHLS" = "GHCup";
        "files.associations" = {
          "*.hs" = "haskell";
        };
        "metals.excludedPackages" = [
        ];
        "cSpell.userWords" = [
        ];
        "cSpell.customDictionaries" = {
        };
        "[jsonc]" = {
          "editor.defaultFormatter" = "vscode.json-language-features";
        };
        "files.exclude" = {
          "**/.DS_Store" = true;
          "**/.git" = true;
          "**/.hg" = true;
          "**/.lsp" = true;
          "**/.svn" = true;
          "**/.vscode" = true;
          "**/.idea" = true;
          "**/CVS" = true;
          "**/Thumbs.db" = true;
          "**/node_modules" = true;
          "**/target" = true;
        };
      };
      profiles.default = {
        userSettings = {
          "[nix]"."editor.tabSize" = 2;
          "[python]"."editor.tabSize" = 4;
        };
      };
      # Extentions
    };
  };
}
