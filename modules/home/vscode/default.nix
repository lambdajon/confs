{pkgs, ...}: {
  config = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      mutableExtensionsDir = true;
      profiles = {
        "test" = {
          # Extensions
          extensions = with pkgs.vscode-extensions; [
            jnoortheen.nix-ide
            # bbenoist.Nix
            rust-lang.rust-analyzer
          ];

          # User settings
          userSettings = {
            "files.autoSave" = "afterDelay";
            "workbench.colorTheme" = "Gruvbox Dark Hard";
          };
        };

        default = {
          # enableExtensionUpdateCheck = false;
          # enableUpdateCheck = false;

          extensions = with pkgs.vscode-extensions;
            [
              bbenoist.nix
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
              ms-vscode.cpptools-extension-pack
              mads-hartmann.bash-ide-vscode
              llvm-vs-code-extensions.vscode-clangd
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
              {
                name = "language-x86-64-assembly";
                publisher = "13xforever";
                version = "3.1.5";
                sha256 = "sha256-WIhmAZLR2WOSqQF3ozJ/Vr3Rp6HdSK7L23T3h4AVaGM=";
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
            chat.disableAIFeatures = true;
            "chat.agent.enabled" = false;
            "chat.commandCenter.enabled" = false;
            "inlineChat.accessibleDiffView" = "off";
            "terminal.integrated.initialHint" = false;
            "editor.tabSize" = 2;
            "extensions.autoCheckUpdates" = false;
            "files.associations" = {
              "*.hs" = "haskell";
              "*.dump-simpl" = "haskell";
              "*.dump-ds" = "haskell";
              "*.project.local" = "haskell";
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
            "haskell.manageHLS" = "PATH";
            "redhat.telemetry.enabled" = true;
            "update.mode" = "none";
            "window.nativeTabs" = true;
            "workbench.colorTheme" = "Gruvbox Dark Medium";
            "workbench.iconTheme" = "material-icon-theme";
            "workbench.productIconTheme" = "material-product-icons";
            haskell = {
              formattingProvider = "fourmolu";
              manageHLS = "PATH";
            };
            "alejandra.program" = "alejandra";
            "[nix]" = {
              "editor.tabSize" = 2;
              "editor.defaultFormatter" = "kamadorueda.alejandra";
              "editor.formatOnPaste" = true;
              "editor.formatOnSave" = true;
              "editor.formatOnType" = false;
            };
            nix = {
              enableLanguageServer = true;
              serverPath = "nixd";
              serverSettings = {
                "nil" = {
                  "formatting" = {
                    "command" = ["alejandra"];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
