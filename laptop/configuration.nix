{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix
      ../configuration.nix
    ];


  ##################################################

  # Not sure if the switch to grub was necessary.
  # I did it at the same time as the luks.devices
  # command, which _was_ necessary to keep my encrypted
  # partition from being overwritten when I tried to boot.

  # # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;

  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "nodev";
    efiSupport = true;
  };

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/disk/by-uuid/62fcaec4-f0c5-4049-a3af-17ce292f2d2d";
      preLVM = true;
      allowDiscards = true;
    }
  ];

  ##################################################


  # This is required to move the pointer with the trackpad.
  services.xserver.synaptics = {
    enable = true;
    tapButtons = false;
  };

  # root doesn't have access to traveller's aliases,
  # so give it a `vim` command.
  environment.systemPackages = with pkgs; [ vim ];

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
