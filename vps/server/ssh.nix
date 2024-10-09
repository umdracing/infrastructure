{ config, pkgs, ... }:

{
  services.sshd.enable = true;
  services.openssh = {
    enable = true;
    # Require public key authentication for better security
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
    ports = [ 45432 ]; # Move SSH port to avoid automatic scanning, "security by obscurity"
  };

  users.users."admin".openssh.authorizedKeys.keys = [
    # "ssh-rsa ..."
  ];
}
