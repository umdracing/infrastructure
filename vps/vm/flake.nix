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
          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;

          users.users.alice = {
            isNormalUser = true;
            initialPassword = "test";
          };
          services.openssh.enable = true;
          networking.firewall.enable = false;
          system.stateVersion = "23.11";

          nixos-shell.mounts = {
            mountHome = false;
            mountNixProfile = false;
            cache = "none"; # default is "loose"
          };

          # Add any VM-specific configurations here
          virtualisation.vmVariant = {
            forwardPorts = [
              { from = "host"; host.port = 2222; guest.port = 22; }
            ];
          };
        })
      ];
    };
  };
}
