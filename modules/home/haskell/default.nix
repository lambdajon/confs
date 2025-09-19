{pkgs, ...}: let
  h = pkgs.haskell.packages."ghc910";
in {
  config = {
    home = {
      packages = [
        h.ghc
        h.cabal-install
        h.haskell-language-server
        h.cabal-fmt
        h.fourmolu
        h.ghcprofview
      ];
    };
  };
}
