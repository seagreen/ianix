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

  # https://www.reddit.com/r/NixOS/comments/4nnfc9/mimicking_the_touchpad_settings_of_macos_on_my/
  services.xserver.synaptics = {
    enable = true; # This is required to move the pointer.
    tapButtons = false;
    twoFingerScroll = true;

    # This makes two finger click into right click,
    # without it it does something weird (maybe middle click?).
    buttonsMap = [ 1 3 2 ]; 

    # Turns out I hit the trackpad with my palm regularly.
    palmDetect = true;
  };

  environment.systemPackages = with pkgs; [
    # root doesn't have access to traveller's aliases,
    # so give it a `vim` command:
    vim
  ];

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
