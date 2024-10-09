{ config, ...}:

{
  services.wordpress.sites."localhost" = {};
  networking.firewall.allowedTCPPorts = [ 80 ]; # Open firewall for http traffic
}
