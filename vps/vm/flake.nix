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

          users.users.root = {
            initialPassword = "test";
          };

          environment.systemPackages = with pkgs; [
            cowsay
            lolcat
          ];

          system.stateVersion = "23.11";

          # Add any VM-specific configurations here
          virtualisation.vmware.guest.enable = true;
        })
      ];
    };
  };
}
