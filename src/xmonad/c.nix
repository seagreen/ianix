{config, pkgs, ... }:

# xmobar guide
# https://wiki.haskell.org/Xmonad/Config_archive/John_Goerzen's_Configuration#Installing_xmobar

{
  environment.systemPackages = with pkgs; [
    haskellPackages.xmobar
    scrot # For screenshots.
  ];

  services.xserver.windowManager = {
    xmonad.enable = true;
    xmonad.enableContribAndExtras = true;
    default = "xmonad";
  };
}
