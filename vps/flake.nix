{
  description = "NixOS configuration for VPS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    defaults = { pkgs, ... }: {
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
    };

    vm = { name, nodes, ... }: {
      deployment = {
        targetUser = "root";
        targetHost = "localhost";
        buildOnTarget = true;
      };
    };

    production = { name, nodes, ... }: {
      deployment = {
        targetUser = "root";
        targetHost = "your-production-ip-or-domain";
        buildOnTarget = true;
      };

      networking.firewall.allowedTCPPorts = [ 80 443 ];
    };

  };
}
