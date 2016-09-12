# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  escoger = pkgs.haskellPackages.callPackage ./extended-nixpkgs/escoger { };
in {

  ############################################################
  # Applications
  ############################################################

  nixpkgs.config.allowUnfree = true;

  # Anything that would require changes to this file in more
  # than one place or has other files associated with it gets
  # factored out to become an import.
  imports = [
    ./desktop/c.nix

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
    camlistore
    chromium
    cloc
    dropbox
    dropbox-cli
    emacs
    escoger
    fasd
    feh
    file
    ffmpeg # Dep of youtubeDL
    gnome3.eog
    (gnupg.override { pinentry = pinentry; })
    go
    gnumake
    gparted
    graphviz # Provides the `dot` executable.
    haskellPackages.aeson-pretty
    htop
    httpie
    i3lock
    imagemagick
    inkscape # Edit pdfs
    jq
    libreoffice
    lynx
    mosh
    mplayer # Required for my weechat beep command.
    mumble
    nix-repl # Basic use: nix-repl '<nixos>'
    nmap
    notmuch
    nox
    pandoc
    pass
    gnuplot
    pwgen
    python27
    python27Packages.ipython
    redis
    shotwell
    silver-searcher
    speedtest_cli
    stdenv # Includes `gcc` for C programming
    telnet
    tmux
    # Pandoc doesn't allow outputing of .pdfs without this as a dep. See here:
    #     https://nixos.org/wiki/TexLive_HOWTO
    #
    # Removed simply because is was building slow:
    # (texLiveAggregationFun { paths = [ texLive texLiveExtra texLiveBeamer lmodern ]; })
    (transmission.override { enableGTK3 = true;})
    tree
    unzip
    vlc
    weechat
    wget
    xboard
    xclip # Let pass access the clipboard.
    xvidcap # Video screenshots
    youtubeDL # ffmpeg is a dep if used with "--audio-format vorbis"
    zathura
  ];

  # NOTE: changes to this take effect on login.
  environment.sessionVariables = {
    EDITOR = "nvim";

    # http://golang.org/doc/install
    GOPATH = "/home/traveller/code/go";
    GOROOT = "${pkgs.go}/share/go";

    # For vim-gnupg specifically, but gpg always wants this, see:
    # https://www.gnupg.org/documentation/manuals/gnupg-devel/Invoking-GPG_002dAGENT.html
    # GPG_TTY = "$(tty)";

    NIX_PATH = pkgs.lib.mkForce [
      "nixpkgs=/home/traveller/code/nixpkgs"
      "nixos=/home/traveller/code/vivaine" # Needed for `nix-repl '<nixos>'`, TODO: does this work?
      "nixos-config=/home/traveller/code/vivaine/configuration.nix"
    ];

    NIXPKGS_ALLOW_UNFREE = "1";

    # Don't create .pyc files.
    PYTHONDONTWRITEBYTECODE = "1";
  };

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

  ############################################################
  # Infrastructure
  ############################################################

  services.xserver.desktopManager.default = "none";

  # X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # setxkbmap settings:
  services.xserver.xkbOptions = "eurosign:e, caps:none";

  # The display manager "provides a graphical login prompt and
  # manages the X server" (from the NixOS manual).
  services.xserver.displayManager = {
    slim.enable = true;
    slim.defaultUser = "traveller";
  };

  services.xserver.displayManager.sessionCommands = ''
    sh /home/traveller/.fehbg &
    xmobar                    &
    dropbox                   &
  '';

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Use ulimit to prevent runaway programs from freezing the computer.
  #
  # View ulimit settings with `ulimit -a`.
  #
  # Test if this is working with:
  #
  #     `echo "a = []\nwhile True: a.append(' ' * 50)" | python`
  security.pam.loginLimits = [{
    domain = "*";
    type = "hard";
    item = "as";
    value = "4000000";
  }];

  services.redshift = {
    enable = true;
    # http://jonls.dk/redshift/
    #
    # When you specify a location manually, note that a location south of equator
    # has a negative latitude and a location west of Greenwich (e.g the Americas)
    # has a negative longitude.
    latitude = "35";
    longitude = "-90"; # Actually about -82, but I wanted redshift to start later.
    temperature = {
      day = 5500;
      night = 2500;
    };
  };
  # Sudden restarts aren't fun on the eyes.
  systemd.services.redshift.restartIfChanged = false;

  # Enable ssh-add. On by default.
  programs.ssh = {
    startAgent = true;
    agentTimeout = null; # Keep keys in memory forever.
  };

  services.openvpn.servers = {
    # systemctl start openvpn-east
    east = {
      config = ''
        cd /home/traveller/code/notes_vivaine/vpn
        config "/home/traveller/code/notes_vivaine/vpn/US East.ovpn"
      '';
      autoStart = false;
    };
  };

  time.timeZone = "America/New_York";
  services.ntp = {
    enable = true;
    servers = [ "server.local" "0.pool.ntp.org" "1.pool.ntp.org" "2.pool.ntp.org" ];
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
    extraGroups = [ "wheel" ];
    uid = 1000;
    createHome = true;
    home = "/home/traveller";
    shell = "${pkgs.zsh}/bin/zsh"; # Changes to this take effect on login.
    openssh.authorizedKeys.keyFiles = [
      "/home/traveller/.ssh/id_rsa.pub"
    ];
  };
}
