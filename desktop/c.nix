{ config, pkgs, ... }:

{
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

  imports = [
      # Include the results of the hardware scan. This is required.
      ./hardware-configuration.nix

      # Backups
      ./../extended-config/tarsnap/c.nix
    ];

  networking.interfaces.enp3s0.ip4 = [ { address = "10.1.101.27"; prefixLength = 24; } ];
  networking.defaultGateway = "10.1.101.1";
  networking.nameservers = [ "8.8.8.8" ];

  networking.firewall.enable = false;
  networking.firewall.allowedTCPPorts = [ 22 60000 ];
  networking.firewall.allowedUDPPorts = [ 22 60000 ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

}
