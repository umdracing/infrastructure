{
  description = "Single NixOS VM configuration for nixos-shell";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-shell.url = "github:Mic92/nixos-shell";
  };

  outputs = { self, nixpkgs, nixos-shell }: {
    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({ config, pkgs, ... }: {
          imports = [ nixos-shell.nixosModules.nixos-shell ];

          boot.loader.grub.enable = false;
          boot.loader.systemd-boot.enable = true;

          networking.useDHCP = false;
          networking.interfaces.eth0.useDHCP = true;
          networking.firewall.enable = false;
          services.openssh.enable = true;
          services.getty.autologinUser = "root";
          users.users.root = {
            password = "";
            openssh.authorizedKeys.keys = [
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF/lGvDlF6HrUaCoZuzbttrcazgSaEkEfnsjADikO3/d"
            ];
          };

          nixos-shell.mounts = {
            mountHome = false;
            mountNixProfile = false;
            cache = "none"; # default is "loose"
          };
          nix.extraOptions = "experimental-features = nix-command flakes";

          environment.systemPackages = with pkgs; [
            git
            htop
          ];

          virtualisation = {
            cores = 2;
            memorySize = 4096;
            diskImage = "./vps/vm/nixos.qcow2";
            forwardPorts = [
              { from = "host"; host.port = 2222; guest.port = 22; }
            ];
          };

          system.stateVersion = "23.11";
        })
      ];
    };
  };
}
