# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


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

  ############################################################
  # Packages and Services
  ############################################################

  nixpkgs.config.allowUnfree = true;

  # Anything that would require changes to this file in more
  # than one place or has other files associated with it gets
  # factored out to become an import.
  imports =
    [ # Include the results of the hardware scan. This is required.
      ./hardware-configuration.nix

      # Window manager
      ./src/xmonad/c.nix

      # Terminal
      ./src/urxvt/c.nix

      # Text editor
      ./src/vim/c.nix

      # Web browser (Vimperator)
      ./src/firefox/c.nix

      # Backups
      ./src/tarsnap/c.nix

      ./src/git/c.nix
      ./src/haskell_dev/c.nix
      ./src/networking/c.nix
      ./src/vagrant/c.nix
    ];

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [

    # Password manager
    pass
    xclip # Let pass access the clipboard.

    # Email
    mutt
    offlineimap

    # Utilities

    bvi # Hex editor
    chromium
    evince # PDF reader.
    fasd
    feh
    gnome3.eog
    # Must edit gpg-agent.conf for gpg to work. See here:
    #
    #     http://lists.gnupg.org/pipermail/gnupg-users/2005-June/026063.html
    gnupg
    gparted
    htop
    i3lock
    libreoffice
    liferea
    mplayer # Required for my weechat beep command.
    pwgen
    sloccount
    speedtest_cli
    tree
    unzip
    vlc
    weechat
    wget
    youtubeDL

    # Activities (personal interests like Go others might not be interested in)

    fabric
    go
    haskellPackages.cabal2nix
    haskellPackages.hakyll
    haskellPackages.hlint
    python27
    python27Packages.ipython
    python27Packages.pyflakes
    python27Packages.virtualenv
    stdenv # Includes `gcc` for C programming

  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  services.xserver.desktopManager.default = "none";

  ############################################################
  # Other Settings
  ############################################################

  networking.hostName = "vivaine";

  # TODO: Is it good to have the TZ hardcoded? Also make sure ntp is working.
  time.timeZone = "America/New_York";
  services.ntp = {
    enable = true;
    servers = [ "server.local" "0.pool.ntp.org" "1.pool.ntp.org" "2.pool.ntp.org" ];
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Unfortunately this makes password management tricky. See here:
  #
  #     https://github.com/NixOS/nixpkgs/issues/3788
  #
  # users.mutableUsers = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.guest = {
    name = "traveller";
    group = "users";
    uid = 1000;
    createHome = true;
    home = "/home/traveller";
    shell = "/run/current-system/sw/bin/bash";
  };

}
