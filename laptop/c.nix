{config, pkgs, ... }:

{
  ############################################################
  # Hardware
  ############################################################

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  imports = [
      # Include the results of the hardware scan. This is required.
      ./hardware-configuration.nix
    ];

  environment.systemPackages = with pkgs; [
    # Currently running xmonadmap by hand to add a second XMonad mod key.
    xorg.xmodmap
  ];
}
