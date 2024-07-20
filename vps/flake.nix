{
  description = "NixOS configuration for VPS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
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
        })
        # Add your custom modules here
        # ./modules/example.nix
        # ./system/configuration.nix
      ];
    };
  };
}
