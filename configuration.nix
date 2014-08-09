# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <nixos/modules/programs/virtualbox.nix>
    ];
  # To install VirtualBox on my Asus VivoPC:
  # Right after power on:
  # F2 > Advanced > CPU Configuration > Intel Virtualization Technology > Enabled
  #
  # Also:
  # usermod -a -G vboxusers traveller # TODO: test if this is necessary.

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


  networking.hostName = "vivaine"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.firefox = {
    enableGoogleTalkPlugin = true;
    enableAdobeFlash = true;
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [

    # Terminal
    rxvt_unicode

    # Text editor
    vim_configurable # This has support for python plugins, which I need for some reason.

    # Web browser
    firefoxWrapper

    # Password management
    pass

    # Email
    mutt
    offlineimap

    # Backups
    tarsnap

    # Basics for Haskell dev via cabal-install sandboxes
    #
    # This is the "Direct Install" strategy discussed here:
    #
    #     https://nixos.org/wiki/Haskell#Direct_installation

    haskellPackages.cabalInstall_1_18_0_3 # Earlier versions don't have `cabal sandbox`.
    haskellPlatform.ghc
    haskellPackages.yesodBin

    # Other stuff for Haskell dev via cabal-install sandboxes

    # Required for yesod or one of its dependencies via cabal-install.
    haskellPackages.alex
    # Required for language-javascript-0.5.13 which is needed for yesod.
    haskellPackages.happy
    # Required for yesod via cabal-install.
    haskellPackages.zlib
    # Maybe needed for `nix-shell` style haskell installs.
    #
    # Definitely needed for language-javascript-0.5.13 via cabal-install
    # (which is needed for yesod). Otherwise you get "The program ar is
    # required but it could not be found."
    stdenv

    # Other Haskell

    haskellPackages.random
    haskellPackages.cabal2nix

    # Other

    # Must edit gpg-agent.conf for this to work. See here:
    #
    #     http://lists.gnupg.org/pipermail/gnupg-users/2005-June/026063.html
    gnupg
    go
    gparted
    chromium
    fasd
    git
    gnome3.eog
    gnome3.gnome-screenshot
    htop
    i3lock
    libreoffice
    liferea
    mplayer # Required for my weechat beep command.
    pwgen
    python27
    python27Packages.pyflakes
    python27Packages.virtualenv
    sloccount
    tree
    vagrant
    vlc
    weechat
    youtubeDL
  ];

  # List services that you want to enable:

  # TODO: did this work?
  services.ntp.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  services.xserver.windowManager.xmonad.enable = true;     # installs xmonad and makes it available
  services.xserver.windowManager.xmonad.enableContribAndExtras = true; # makes xmonad-contrib and xmonad-extras available
  services.xserver.windowManager.default       = "xmonad"; # sets it as default
  services.xserver.desktopManager.default      = "none";   # the plain xmonad experience

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
