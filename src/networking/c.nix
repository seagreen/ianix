{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Needed for nmapplet, but not nmcli.
    networkmanagerapplet

    # Fake system tray for nmapplet.
    stalonetray 
  ];

  networking.networkmanager.enable = true;
  users.extraGroups.networkmanager.members = [ "root" ];

  networking.nameservers = [ "8.8.8.8" ];
}
