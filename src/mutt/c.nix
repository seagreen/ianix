{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ abook mutt ];
}
