{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ msmtp ];
}
