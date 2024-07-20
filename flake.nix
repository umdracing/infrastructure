{
  description = "Development environment for VPS management";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nixos-shell
        ];

        shellHook = ''
          echo "Welcome to the minimal dev environment!"
        '';
      };
    };
}