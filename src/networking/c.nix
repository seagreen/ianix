{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  users.extraGroups.networkmanager.members = [ "root" ];

  networking.nameservers = [ "8.8.8.8" ];
}
