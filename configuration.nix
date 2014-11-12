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
  # Applications
  ############################################################

  nixpkgs.config.allowUnfree = true;

  # Anything that would require changes to this file in more
  # than one place or has other files associated with it gets
  # factored out to become an import.
  imports =
    [ # Include the results of the hardware scan. This is required.
      ./hardware-configuration.nix

      # Window manager
      ./extended-config/xmonad/c.nix

      # Terminal
      ./extended-config/urxvt/c.nix

      # Shell
      ./extended-config/zsh/c.nix

      # Text editor
      ./extended-config/vim/c.nix

      # Email
      ./extended-config/mbsync/c.nix # IMAP client
      ./extended-config/mutt/c.nix
      ./extended-config/msmtp/c.nix # SMTP client

      # Web browser (Vimperator)
      ./extended-config/firefox/c.nix

      # Backups
      ./extended-config/tarsnap/c.nix

      ./extended-config/git/c.nix
      ./extended-config/haskell_dev/c.nix
      ./extended-config/networking/c.nix
      ./extended-config/virtualbox/c.nix
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
    ffmpeg # Dep of youtubeDL
    gnome3.eog
    # Must edit gpg-agent.conf for gpg to work. See here:
    #
    #     http://lists.gnupg.org/pipermail/gnupg-users/2005-June/026063.html
    gnupg
    gparted
    graphviz # Provides the `dot` executable. Dep of haskellPackages.SourceGraph
    haskellPackages.aesonPretty
    haskellPackages.escoger
    htop
    i3lock
    jq
    libreoffice
    liferea
    mplayer # Required for my weechat beep command.
    jmtpfs
    notmuch
    pwgen
    silver-searcher
    sloccount
    speedtest_cli
    tree
    unzip
    vlc
    weechat
    wget
    youtubeDL # ffmpeg is a dep if used with "--audio-format vorbis"

    # Activities (personal interests like Go others might not be interested in)

    fabric
    go
    haskellPackages.cabal2nix
    haskellPackages.ghcMod
    # hakyll is currently broken, but it doesn't matter too much
    # since it's only needed for initializing new sites.
    # haskellPackages.hakyll 
    haskellPackages.haddock # Not necessary for `cabal haddock`.
    haskellPackages.hlint
    haskellPackages.hoogleLocal
    haskellPackages.SourceGraph # graphviz is a dep
    pylint
    python27
    python27Packages.ipython
    python27Packages.pyflakes
    python27Packages.virtualenv
    stdenv # Includes `gcc` for C programming

  ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql94;
    port = 5432; # Make the default explicit.
    authentication = pkgs.lib.mkForce
      ''
        local    all all                trust
        host     all all 127.0.0.1/32   trust
      '';
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.redshift = {
    enable = true;
    # Latitude and longitude are required, but accept empty strings.
    latitude = "";
    longitude = "";
  };
  # Sudden restarts aren't fun on the eyes.
  systemd.services.redshift.restartIfChanged = false;

  # The display manager "provides a graphical login prompt and
  # manages the X server" (from the NixOS manual).
  services.xserver.displayManager = {
    slim.enable = true; # Make the default explicit.
    slim.defaultUser = "traveller";
  };

  ############################################################
  # Infrastructure
  ############################################################

  networking.hostName = "vivaine";

  services.xserver.desktopManager.default = "none";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

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
  users.extraUsers.traveller = {
    name = "traveller";
    group = "users";
    uid = 1000;
    createHome = true;
    home = "/home/traveller";
    shell = "${pkgs.zsh}/bin/zsh"; # Requires a restart to detect changes.
  };

}
