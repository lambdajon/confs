{
  description = "Take n flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { self, nixpkgs, nur, home-manager, ... } :
    let
      system = "x86_64-linux";
      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];

      forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});

      pkgsFor = lib.genAttrs systems (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        });

      pkgs = import nixpkgs {
        localSystem = { inherit system; };
        config = {
          allowUnfree = true;
          cudaSupport = true;
        };
        overlays = [
          nur.overlay
        ];
      };

      mkSystem = { hostname, username, modules ? [ ] }: nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit inputs hostname username; };
        modules = [
          ./machines/${hostname}/configuration.nix
          ./modules/core/nix.nix
        ] ++ modules;
      };
    in
    {
      formatter.x86_64-linux = pkgs.nixpkgs-fmt;

      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      
      nixosConfigurations = {
        alpha = let username = "lambdajon"; in mkSystem {
          inherit username;
          hostname = "alpha";
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./machines/alpha/home-manager.nix;
            }
          ];
        };
      };
    };
}
