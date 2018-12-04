{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ firefox ];
}

# This was having trouble installing:
#
# {
#   environment.systemPackages = with pkgs; [ firefoxWrapper ];
#
#   nixpkgs.config.firefox = {
#     enableGoogleTalkPlugin = true;
#     enableAdobeFlash = true;
#   };
# }
