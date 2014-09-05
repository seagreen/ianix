{config, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [
    # For screenshots.
    scrot 
  ];

  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.windowManager.default = "xmonad";
}









