{
  description = "Ben's NixOS + home-manager + sops-nix + disko configuration + nixpkgs overlay";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix user repository, including Firefox extensions.
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, disko, nur }: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
    };
  in {
    devShells.x86_64-linux.default = with pkgs; mkShell {
      buildInputs = [
        just
        nil
        # Secrets management.
        ssh-to-age
        (sops.withAgePlugins (plugins: [
          plugins.age-plugin-fido2-hmac # Allows me to use my hardware token with sops.
        ]))
      ];
    };

    overlays.default = final: prev: import ./pkgs prev;

    nixosConfigurations.wunstpc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko

        sops-nix.nixosModules.default
        nur.modules.nixos.default
        ./modules
        ./systems/wunstpc
        {
          nixpkgs.overlays = [
            self.overlays.default
          ];
        }
        ./allow-unfree.nix
      ];

      specialArgs = {
        secrets = ./secrets;
      };
    };
  };
}
