{
  # Fucking slaves, get your ass back here!
  description = "Samurai with cat's nix configurations";

  # inputs are other flakes you use within your own flake, dependencies
  # for your flake, etc.
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/home.nix'.

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake utils for eachSystem
    flake-utils.url = "github:numtide/flake-utils";

    # Nix user repositories for more obscure community packages
    nur.url = "github:nix-community/NUR";

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";
  };

  # In this context, outputs are mostly about getting home-manager what it
  # needs since it will be the one using the flake
  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , flake-utils
    , ...
    } @ inputs:
    let
      # Self instance pointer
      outputs = self;

      # Attribute for each system (system specific ones)
      afes = flake-utils.lib.eachDefaultSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          # Nixpkgs packages for the current system
          {
            # Your custom packages
            # Acessible through 'nix build', 'nix shell', etc
            packages = import ./pkgs { inherit pkgs; };

            # Formatter for your nix files, available through 'nix fmt'
            # Other options beside 'alejandra' include 'nixpkgs-fmt'
            formatter = pkgs.nixpkgs-fmt;

            # Development shells
            devShells.default = import ./shell.nix { inherit pkgs; };
          });

      # Attribute from static evaluation
      afse = {
        # Nixpkgs and Home-Manager helpful functions
        lib = nixpkgs.lib // home-manager.lib;

        # Your custom packages and modifications, exported as overlays
        overlays = import ./overlays { inherit inputs; };

        # Reusable nixos modules you might want to export
        # These are usually stuff you would upstream into nixpkgs
        nixosModules = import ./modules/nixos;

        # Reusable home-manager modules you might want to export
        # These are usually stuff you would upstream into home-manager
        homeManagerModules = import ./modules/home;

        # NixOS configuration entrypoint
        # Available through 'nixos-rebuild --flake .#your-hostname'
        nixosConfigurations = {
          "Alpha" = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs outputs; };
            modules = [
              # > Our main nixos configuration file <
              ./nixos/alpha/configuration.nix
            ];
          };
        };

        # Standalone home-manager configuration entrypoint
        # Available through 'home-manager --flake .#your-username@your-hostname'
        homeConfigurations = {
          # For all current OSX machines
          "akhmadiy@apple" = home-manager.lib.homeManagerConfiguration {
            pkgs =
              nixpkgs-unstable.legacyPackages.aarch64-darwin; # Home-manager requires 'pkgs' instance
            extraSpecialArgs = { inherit inputs outputs; };
            modules = [
              # > Our main home-manager configuration file <
              ./home/macos.nix
            ];
          };

          # Shortcuts for auto detection
          "akhmadiy@Akhmadiys-Macbook-Pro.local" = self.homeConfigurations."akhmadiy@apple"; # MacBook Pro
        };
      };
    in
    # Merging all final results
    afes // afse;

  # mkSystem = { hostname, username, modules ? [ ] }: nixpkgs.lib.nixosSystem {
  #   inherit system pkgs;
  #   specialArgs = { inherit inputs hostname username; };
  #   modules = [
  #     ./machines/${hostname}/configuration.nix
  #     ./modules/core/nix.nix
  #   ] ++ modules;
  # };

  # {
  #   nixosConfigurations = {
  #     alpha = let username = "lambdajon"; in mkSystem {
  #       inherit username;
  #       hostname = "alpha";

  #       modules = [
  #         home-manager.nixosModules.home-manager
  #         {
  #           home-manager.useGlobalPkgs = true;
  #           home-manager.useUserPackages = true;
  #           home-manager.users.${username} = import ./machines/alpha/home-manager.nix;
  #         }
  #       ];
  #     };
  #   };
  # };
}
