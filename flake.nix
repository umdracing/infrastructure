{
  description = "Development environment for VPS management";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
#    flake-utils.url = "github:numtide/flake-utils";
    vps.url = "./VPS";
  };

  outputs = { self, nixpkgs, flake-utils, vps, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # VM configuration
        vm = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            vps.nixosConfigurations.default.config
            ({ config, ... }: {
              virtualisation.vmVariant = {
                virtualisation = {
                  memorySize = 2048;
                  cores = 2;
                };
              };
            })
          ];
        };

      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nix
            colmena
            qemu
            nixos-shell
          ];

          shellHook = ''
            echo "VPS development environment loaded"
            echo "Use 'colmena build' to build the configuration"
            echo "Use 'colmena apply' to deploy to the VM"
            echo "Use 'nixos-shell --flake .#vm' to start the VM"
          '';
        };

        # Colmena configuration
        colmena = {
          meta = {
            description = "VPS deployment configuration";
            nixpkgs = nixpkgs.outPath;
            specialArgs = { inherit vps; };
          };

          vm = { name, nodes, ... }: {
            deployment = {
              targetHost = "localhost";
              targetUser = "root";
            };

            imports = [ vps.nixosConfigurations.default.config ];
          };
        };

        # VM configuration
        nixosConfigurations.vm = vm;
      });
}
