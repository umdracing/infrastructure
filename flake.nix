{
  description = "Development environment for VPS management";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    colmena.url = "github:zhaofengli/colmena";
  };
  outputs = { self, nixpkgs, colmena }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          git
          pipewire
          jack2
          qemu
          nixos-shell # Spawns lightweight nixos vms in a shell
          colmena.packages.${system}.colmena
        ];
        shellHook = ''
          echo "Welcome to the dev environment!"
          echo "Launch VM with the following command:"
          echo "nixos-shell --flake ./vps#vm"
          echo "Deploy to VM or production with:"
          echo "colmena apply --on @vm"
          echo "colmena apply --on @production"
        '';
      };
    };
}
