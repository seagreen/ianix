{config, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [ tarsnap ];
}
