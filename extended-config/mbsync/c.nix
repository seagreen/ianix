{config, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [ isync ];

  services.cron.systemCronJobs = [
    # Run every 5 minutes.
    #
    # The -a flag syncs all accounts.
    #
    # Note that we have to add ~/bin to PATH manually. This is necessary
    # because .mbsyncrc uses the pass-plain command, which is stored in ~/bin.
    "*/5 * * * * traveller export PATH=$PATH:~/bin; mbsync -a"
  ];
}
