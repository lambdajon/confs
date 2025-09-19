{pkgs, ...}: {
  config = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;

      profiles.default = {
        enableExtensionUpdateCheck = false;
        enableUpdateCheck = false;

        extensions = with pkgs.vscode-extensions;
          [
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
            # scalameta.metals
            #scala-lang.scala
            timonwong.shellcheck
            # vscodevim.vim
            donjayamanne.githistory
            github.vscode-github-actions
            jebbs.plantuml
            mechatroner.rainbow-csv
            redhat.vscode-yaml
            pkief.material-icon-theme
            streetsidesoftware.code-spell-checker
            zhuangtongfa.material-theme
            ziglang.vscode-zig
            banacorn.agda-mode
            gruntfuggly.todo-tree
            oderwat.indent-rainbow
          ]
          ++ pkgs.vscode-utils. extensionsFromVscodeMarketplace [
            {
              name = "lean4";
              publisher = "leanprover";
              version = "0.0.212";
              sha256 = "b74aeff0fa04ea51313078bd5d432fc10c490007a1250dd96ae9b8c1916c9f86";
            }
            {
              name = "markdowntable";
              publisher = "takumii";
              version = "0.11.0";
              sha256 = "kn5aLRaxxacQMvtTp20IdTuiuc6xNU3QO2XbXnzSf7o=";
            }

          ];

        # User defined setings (raw json)
        userSettings = {
          "[javascript]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[json]" = {
            "editor.defaultFormatter" = "vscode.json-language-features";
          };
          "[jsonc]" = {
            "editor.defaultFormatter" = "vscode.json-language-features";
          };
          "[markdown]" = {
            "editor.wordWrap" = "wordWrapColumn";
            "editor.wordWrapColumn" = 120;
            "editor.wrappingIndent" = "same";
            "vim.textwidth" = 120;
          };
          "[typescript]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[yaml]" = {
            "editor.defaultFormatter" = "redhat.vscode-yaml";
          };
          "cSpell.customDictionaries" = {
          };
          "cSpell.userWords" = [
          ];
          "editor.tabSize" = 2;
          "extensions.autoCheckUpdates" = false;
          "files.associations" = {
            "*.hs" = "haskell";
          };
          "files.autoSave" = "afterDelay";
          "files.exclude" = {
            "**/.DS_Store" = true;
            "**/.git" = true;
            "**/.hg" = true;
            "**/.idea" = true;
            "**/.lsp" = true;
            "**/.svn" = true;
            "**/.vscode" = true;
            "**/CVS" = true;
            "**/Thumbs.db" = true;
            "**/node_modules" = true;
            "**/target" = true;
          };
          "files.watcherExclude" = {
            "**/.ammonite" = true;
            "**/.bloop" = true;
          };
          "haskell.manageHLS" = "GHCup";
          "redhat.telemetry.enabled" = true;
          "update.mode" = "none";
          "window.nativeTabs" = true;
          "workbench.colorTheme" = "Gruvbox Dark Medium";
          "workbench.iconTheme" = "material-icon-theme";
          "workbench.productIconTheme" = "material-product-icons";
        };
      };
    };
  };
}
