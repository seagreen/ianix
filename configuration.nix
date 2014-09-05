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

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Web browser
      ./sets/firefox.nix

      ./sets/haskell-dev.nix
      ./sets/vagrant.nix
    ];

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [

    # Terminal
    rxvt_unicode

    # Text editor
    vim_configurable # This has support for python plugins, which I need for some reason.

    # Password manager
    pass

    # Email
    mutt
    offlineimap

    # Backups
    tarsnap

    # Utilities

    # Must edit gpg-agent.conf for gpg to work. See here:
    #
    #     http://lists.gnupg.org/pipermail/gnupg-users/2005-June/026063.html
    gnupg
    gparted
    chromium
    fasd
    feh
    git
    gnome3.eog
    gnome3.gnome-screenshot
    htop
    i3lock
    libreoffice
    liferea
    mplayer # Required for my weechat beep command.
    networkmanagerapplet # Needed for nmapplet, but not nmcli.
    pwgen
    scrot # For screenshots.
    sloccount
    speedtest_cli
    stalonetray # Fake system tray for programs like nmapplet that require one.
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

  ];

  # Enable NetworkManager and OpenVPN.
  networking.networkmanager.enable = true;
  users.extraGroups.networkmanager.members = ["root"];
  # networking.wireless.enable = true;
  services.openvpn.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.windowManager.default = "xmonad";
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
