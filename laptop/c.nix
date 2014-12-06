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

      # Backups
      ./../extended-config/tarsnap/c.nix
    ];

  environment.systemPackages = with pkgs; [
    # Currently running xmonadmap by hand to add a second XMonad mod key.
    xorg.xmodmap
  ];

  # Make left Command an Xmonad meta key. Needed for sanity since
  # on my laptop it's directly to the left of spacebar.
  services.xserver.displayManager.sessionCommands = ''
    xmodmap -e "keycode 133 = Alt_L"
    xmodmap -e "remove mod4 = Alt_L"
    xmodmap -e "add mod1 = Alt_L"
  '';

  # TODO: having to run:
  #
  #     $ TERM="rxvt-256color"
  #
  # manually for mutt colors to work.
}
