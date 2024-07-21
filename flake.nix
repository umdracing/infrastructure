{
  description = "Development environment for VPS management";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          git # Distributed version control system
          nixos-shell # Spawns lightweight nixos vms in a shell
          colmena # A simple, stateless NixOS deployment tool
          vagrant # Tool for building complete development environments
        ];
        shellHook = ''
          echo "Welcome to the dev environment!"
          echo "Launch VM with the following command:"
          echo "nixos-shell --flake ./vps/vm#vm"
          echo ""
          echo "Navigate to machine directory (e.g. vps/)"
          echo "Deploy to VM or production with:"
          echo "colmena apply --on vm"
          echo "colmena apply --on production"
          
          vagrant plugin install vagrant-nixos-plugin
        '';
      };
    };
}
