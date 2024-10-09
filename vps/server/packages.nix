{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    htop # An interactive process viewer
    magic-wormhole # Securely transfer data between computers
    nano
  ];
}
