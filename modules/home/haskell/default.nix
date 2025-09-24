{pkgs, ...}: let
  h = pkgs.haskell.packages."ghc910";
in {
  config = {
    home = {
      file.".ghci".text = ''
        :set +t
        :set +m
        :set prompt "\ESC[1;35m\x03BB> \ESC[m"
        :set prompt-cont "\ESC[1;35m > \ESC[m"
      '';
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
