{ config, pkgs, ... }:

# See here for details on Vim in NixOS:
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/vim-plugins/vim-utils.nix
#
# It uses VAM (Vim Addon Manager) internally:
# https://github.com/MarcWeber/vim-addon-manager
{
  environment.systemPackages = with pkgs; [
    (neovim.override {
      configure = {
        vam = {
          knownPlugins = vimPlugins // ({

            # Custom plugins go here.
            #
            # Note that you can't copy a package from here straight into the vimPlugins
            # module without checking if it works, the environment is slightly different
            # (for example we have to specify vimUtils.buildVimPluginFrom2Nix here
            # instead of just buildVimPluginFrom2Nix).

            exampleCustomPackage = vimUtils.buildVimPluginFrom2Nix {
              name = "vim-gista-2016-01-23";
              src = fetchgit {
                url = "git://github.com/lambdalisue/vim-gista";
                rev = "2021858d9cada2289a866387ba728dd025093aa1";
                sha256 = "1e3e925cdb6a9296f20c2261efb96eac0792e12c3b7a4f6a1637ac0a96255eb4";
              };
              dependencies = [];
            };

            # intero = vimUtils.buildVimPluginFrom2Nix {
            #   name = "intero";
            #   src = fetchgit {
            #     url = "git://github.com/myfreeweb/intero.nvim";
            #     rev = "2ab44a0dd4d34bc7c210b8b7db8b01a28827a28f";
            #     sha256 = "1rycsppq5m06bqnd4zi9k969iapddf7yq1dnaphpzf1zj710pbzx";
            #   };
            #   dependencies = [];
            # };

            intero-neovim = vimUtils.buildVimPluginFrom2Nix {
              name = "intero-neovim";
              src = fetchgit {
                url = "git://github.com/parsonsmatt/intero-neovim";
                rev = "113543022504364b0173f68b67141170c6aef0d1";
                sha256 = "1c15cnwcpvfy94rx3vcs5n8i7pyz1rr0h0gpic9iqsgxawvw8arr";
              };
              dependencies = [];
            };

          });

          # There's a list of available plugins here:
          # https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/vim-plugins/vim-plugin-names
          pluginDictionaries = [

            ##################################################
            # general
            ##################################################

            { name = "vim-colorschemes"; }
            { name = "neomake"; }
            { name = "supertab"; } # Tab completion.
            { name = "Tabular"; } # Line up text.
            { name = "ctrlp"; }
            { name = "vim-gitgutter"; }
            { name = "vinegar"; }
            # Distraction-free writing in Vim. Recommended here for use with Markdown files:
            #
            #     https://news.ycombinator.com/item?id=6978563
            #
            # The same author also wrote this:
            #
            #     https://github.com/bilalq/lite-dfm
            #
            # which he uses for coding (it doesn't line up as well but keeps support for
            # vsplits uncrippled.
            { name = "goyo"; }


            ##################################################
            # haskell
            ##################################################

            { name = "syntastic"; }

            { name = "ghcmod"; ft_regex = "^haskell\$"; }
            { name = "vimproc"; } # Required by ghcmod.
            # A completion plugin for haskell using ghc-mod:
            { name = "neco-ghc"; ft_regex = "^haskell\$"; }

            # { name = "intero-neovim"; }

            ##################################################
            # other
            ##################################################

            { name = "vim2nix"; }
            { name = "exampleCustomPackage"; }

          ];
        };
        customRC = ''
          source /home/traveller/.config/nvim/init.vim
        '';
      };
    })
  ];
}
