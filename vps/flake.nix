{
  description = "NixOS configuration for VPS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    colmena = {
      meta = {
        nixpkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = [ ];
        };
      };

      defaults = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
          cowsay
          lolcat
        ];
        #services.openssh.enable = true;

        system.stateVersion = "23.11";
      };

      vm = { name, nodes, ... }: {
        deployment = {
          targetUser = "root";
          targetHost = "localhost";
          targetPort = 2222;
          #allowLocalDeployment = true;
          buildOnTarget = true;
        };
        boot.loader.grub.device = "/dev/vda";
        fileSystems."/" = {
          device = "/dev/vda1";
          fsType = "ext4";
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
  };
}
