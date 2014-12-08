# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


{

  ############################################################
  # Applications
  ############################################################

  nixpkgs.config.allowUnfree = true;

  # Anything that would require changes to this file in more
  # than one place or has other files associated with it gets
  # factored out to become an import.
  imports = [
    ./laptop/c.nix

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

    ./extended-config/git/c.nix
    ./extended-config/haskell_dev/c.nix
    ./extended-config/networking/c.nix
    ./extended-config/virtualbox/c.nix
  ];

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    bvi # Hex editor
    camlistore
    chromium
    evince
    fabric
    fasd
    feh
    ffmpeg # Dep of youtubeDL
    gnome3.eog
    (gnupg.override { pinentry = pinentry; })
    go
    gparted
    graphviz # Provides the `dot` executable. Dep of haskellPackages.SourceGraph
    haskellPackages.aesonPretty
    haskellPackages.cabal2nix
    haskellPackages.escoger
    haskellPackages.ghcMod
    haskellPackages.hakyll
    haskellPackages.haddock # Not necessary for `cabal haddock`.
    haskellPackages.hlint
    haskellPackages.hoogleLocal # Use: `hoogle search -- "a -> a"`
    # haskellPackages.SourceGraph # graphviz is a dep # BROKEN
    htop
    i3lock
    ihaskell
    jmtpfs
    jq
    # TODO: broken
    # libreoffice
    liferea
    lynx
    mpd # Music Player Daemon
    mplayer # Required for my weechat beep command.
    nix-repl # Basic use: nix-repl '<nixos>'
    notmuch
    nox
    pass
    pwgen
    pylint
    python27
    python27Packages.ipython
    python27Packages.pyflakes
    python27Packages.virtualenv
    silver-searcher
    sloccount
    speedtest_cli
    stdenv # Includes `gcc` for C programming
    strategoPackages.strategoxt # Pretty print .drv file with `pp-aterm -i <file>.drv`
    tree
    unzip
    vimpc # Vim inspired client for mpd.
    vlc
    weechat
    wget
    xclip # Let pass access the clipboard.
    youtubeDL # ffmpeg is a dep if used with "--audio-format vorbis"
  ];

  # The display manager "provides a graphical login prompt and
  # manages the X server" (from the NixOS manual).
  services.xserver.displayManager = {
    slim.enable = true;
    slim.defaultUser = "traveller";
  };

  services.xserver.displayManager.sessionCommands = ''
    sh /home/traveller/.fehbg
  '';

  services.redshift = {
    enable = true;
    # Latitude and longitude are required, but accept empty strings.
    latitude = "";
    longitude = "";
  };
  # Sudden restarts aren't fun on the eyes.
  systemd.services.redshift.restartIfChanged = false;

  # Enable ssh-add. On by default.
  programs.ssh = {
    startAgent = true;
    agentTimeout = null; # Keep keys in memory forever.
  };

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

  ############################################################
  # Infrastructure
  ############################################################

  networking.hostName = "vivaine";

  services.xserver.desktopManager.default = "none";

  # X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # xkeyboard-config settings:
  services.xserver.xkbOptions = "eurosign:e, caps:none";

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
