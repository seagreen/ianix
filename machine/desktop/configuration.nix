{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ../../shared.nix

      # Backups
      # ../../src/tarsnap/c.nix
    ];

  networking.hostName = "nivian";

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    version = 2;
    # Define on which hard drive you want to install Grub.
    device = "/dev/sda";
  };

  boot.initrd.luks.devices = [
    {
      name = "root"; device = "/dev/sda3"; preLVM = true;
    }
  ];

  networking.firewall.enable = true;
  # Note that when openssh is enabled port 22 is opened automatically.
  networking.firewall.allowedTCPPorts = [ 2213 62213 62214 ];
  networking.firewall.allowedUDPPorts = [ 2213 62213 62214 ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    ports = [ 2213 ];
  };

}
