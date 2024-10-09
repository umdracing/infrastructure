{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    # Common configuration for both VM and VPS
    commonModules = [
        ./server/configuration.nix
        ./server/hardware.nix
        ./server/locale.nix
        ./server/packages.nix
        ./server/ssh.nix
        ./server/users.nix
        ./services/wordpress.nix
    ];

    # VM-specific configuration
    vmModules = [
      ({ config, pkgs, modulesPath, ... }: {
        virtualisation.vmVariant = {
          # VM-specific options
          #imports = [ (modulesPath + "/virtualisation/qemu-vm.nix") ];
          virtualisation.memorySize = 2048; # Example: 2GB RAM
          virtualisation.cores = 2;         # Example: 2 CPU cores
          virtualisation.forwardPorts = [
            { from = "host"; host.port = 2222; guest.port = 45432; } # SSH port
            { from = "host"; host.port = 8080; guest.port = 80; } # Http port, initally for Wordpress
          ];
        };
      })
    ];

    # VPS-specific configuration (if any)
    vpsModules = [
      # Add any VPS-specific modules or options
    ];
  in
  {
    nixosConfigurations = {
      # Configuration for VM
      vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonModules ++ vmModules;
      };

      # Configuration for VPS
      vps = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonModules ++ vpsModules;
      };
    };
  };
}
