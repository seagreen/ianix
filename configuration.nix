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

      # Email
      ./src/mbsync/c.nix # IMAP client
      ./src/mutt/c.nix
      ./src/msmtp/c.nix # SMTP client

      # Web browser (Vimperator)
      ./src/firefox/c.nix

      # Backups
      ./src/tarsnap/c.nix

      ./src/git/c.nix
      ./src/haskell_dev/c.nix
      ./src/networking/c.nix
      ./src/virtualbox/c.nix
    ];

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [

    # Password manager
    pass
    xclip # Let pass access the clipboard.

    # Utilities

    bvi # Hex editor
    # chromium
    evince
    fasd
    feh
    gnome3.eog
    # Must edit gpg-agent.conf for gpg to work. See here:
    #
    #     http://lists.gnupg.org/pipermail/gnupg-users/2005-June/026063.html
    gnupg
    gparted
    haskellPackages.escoger
    htop
    i3lock
    libreoffice
    liferea
    mplayer # Required for my weechat beep command.
    notmuch
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
    (haskellPackages.ghcWithPackages (self : [
      haskellPackages.aeson
      haskellPackages.errors
      haskellPackages.mtl # Needed for Control.Monad.Writer
      haskellPackages.random
      haskellPackages.wreq
    ]))
    # haskellPackages.hakyll # hakyll is currently broken, but it doesn't matter too much
    # since it's only needed for initializing new sites
    haskellPackages.haddock # Not necessary for `cabal haddock`.
    haskellPackages.hlint
    haskellPackages.SourceGraph
    # haskellPlatform
    pylint
    python27
    python27Packages.ipython
    python27Packages.pyflakes
    python27Packages.virtualenv
    stdenv # Includes `gcc` for C programming

  ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";

    desktopManager.default = "none";

    # SLiM is the default display manager for NixOS. The line below
    # just makes that explicit.
    #
    # The display manager "provides a graphical login prompt and
    # manages the X server" (from the NixOS manual).
    displayManager.slim.enable = true;
    displayManager.slim.defaultUser = "traveller";
  };

  services.redshift = {
    enable = true;
    # Latitude and longitude are required, but accept empty strings.
    latitude = "";
    longitude = "";
  };
  # Sudden restarts aren't fun on the eyes.
  systemd.services.redshift.restartIfChanged = false;

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
