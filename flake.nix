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
        ];
        shellHook = ''
          echo "Welcome to the dev environment!"
          echo ""
          echo "Create and launch VM with the following command:"
          echo ""
          echo "nix run ./vps#nixosConfigurations.vm.config.system.build.vm"
          echo ""
          echo "This should start a wordpress instance, that can be reached under:"
          echo "http://localhost:8080"
          echo ""
          echo "You can connect to the VM with the following command, assuming that you added your SSH key to the config:"
          echo "ssh -p 2222 -i ssh/your-ssh-key-if-not-default admin@localhost"
        '';
      };
    };
}