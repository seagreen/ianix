{ config, pkgs, ... }:

# My old Asus VivoPC required this (press F2 right after power on):
#
#   F2 > Advanced > CPU Configuration > Intel Virtualization Technology > Enabled

{
  services.virtualboxHost.enable = true;

  # NOTE: Getting this message:
  #
  #     warning: Hardening is currently disabled for VirtualBox, because of some issues in conjunction with host-only-interfaces. If you don't use hostonlyifs, it's strongly recommended to set `services.virtualboxHost.enableHardening = true'!
  #
  # But with that line running VirtualBox gives this error:
  #
  #     VirtualBox: Effective UID is not root (euid=1000 egid=100 uid=1000 gid=100)

  environment.systemPackages = with pkgs; [ vagrant ];

  users.extraGroups.vboxusers.members = [ "traveller" ];
}
