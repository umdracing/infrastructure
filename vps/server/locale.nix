{ config, lib, ... }:

{
  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de-latin1";
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "de";
  # services.xserver.xkbOptions = "eurosign:e";
}
