{config, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [ rxvt_unicode ];
}
