{
  description = "NixOS configuration for vm clone of VPS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({ config, pkgs, ... }: {
          imports = [ <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix> ];
          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;

          users.users.alice = {
            isNormalUser = true;
            initialPassword = "test";
          };
          services.openssh.enable = true;
          networking.firewall.enable = false;
          system.stateVersion = "23.11";

          # Add any VM-specific configurations here
          virtualisation = {
            forwardPorts = [
              { from = "host"; host.port = 2222; guest.port = 22; }
            ];
          };
        })
      ];
    };
  };
}
