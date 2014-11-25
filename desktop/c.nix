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

  boot.initrd.luks.devices = [
    {
      name = "root"; device = "/dev/sda3"; preLVM = true;
    }
  ];

  imports = [
      # Include the results of the hardware scan. This is required.
      ./hardware-configuration.nix

      # Backups
      ./../extended-config/tarsnap/c.nix
    ];
}
