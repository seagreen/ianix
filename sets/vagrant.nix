{ config, pkgs, ... }:


{
  imports = [ <nixos/modules/programs/virtualbox.nix> ];

  environment.systemPackages = with pkgs; [ vagrant ];

  # Also run:
  #
  #     usermod -a -G vboxusers traveller

  # Also required on my Asus VivoPC (right after power on):
  #
  #   F2 > Advanced > CPU Configuration > Intel Virtualization Technology > Enabled
}
