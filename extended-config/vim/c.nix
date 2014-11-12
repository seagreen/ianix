{config, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [
    # If I just use plain "vim" I get this error:
    #
    #     Error: jedi-vim requires vim compiled with +python
    #
    # Additionally pasting into vim via the middle mouse key
    # may not work with the plain "vim" package.
    vim_configurable
  ];
}
