{ config, pkgs, ... }:

{
  users.users.admin = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    # Hashed password can be generated using "mkpasswd" command
    # This is world-readable and only for simplicity during testing
    hashedPassword = "$y$j9T$kdJKoA/kIj.0UVG0ilVa00$DE241FyFNj6q3RcGD7z2.N/TlmfL3NtsolPVmFp1YYA";
  };
}
