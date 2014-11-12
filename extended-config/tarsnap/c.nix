{config, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [ tarsnap ];

  services.cron.systemCronJobs = [
    # Backup every day at 4 in the morning.
    "0 4 * * * traveller /home/traveller/bin/backup"
  ];
}
