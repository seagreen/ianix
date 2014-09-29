{config, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [ isync ];

  services.cron.systemCronJobs = [
    # Run every 5 minutes.
    # The -a flag syncs all accounts.
    # Note that we have to add ~/bin to PATH manually.
    "*/5 * * * * traveller export PATH=$PATH:~/bin; mbsync -a"
  ];
}
