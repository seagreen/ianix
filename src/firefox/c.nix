{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ firefoxWrapper ];

  nixpkgs.config.firefox = {
    enableGoogleTalkPlugin = true;
    enableAdobeFlash = true;
  };
}
