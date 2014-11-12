{ config, pkgs, ... }:

# Required on my Asus VivoPC (right after power on):
#
#   F2 > Advanced > CPU Configuration > Intel Virtualization Technology > Enabled

{
  imports = [ <nixos/modules/programs/virtualbox.nix> ];

  environment.systemPackages = with pkgs; [ vagrant ];

  users.extraGroups.vboxusers.members = [ "traveller" ];

}
