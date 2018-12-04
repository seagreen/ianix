{ config, pkgs, ... }:

# Resources:
#
# https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/vim.section.md
#
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/vim-plugins/vim-utils.nix
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
            { "names" = [
                ##################################################
                # general
                ##################################################

                "elm-vim"

                # Both of these seem to be required, as well as the `fzf` package.
                "fzf-vim"
                "fzfWrapper"

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
                "goyo"

                "nerdtree"
                # "neomake"
                # "supertab" # Tab completion.
                # "Tabular" # Line up text.
                "vim-colorschemes"
                "vim-gitgutter"
                # "vinegar"

                ##################################################
                # other
                ##################################################

                "vim2nix"
                # "exampleCustomPackage"
              ];
            }
          ];
        };
        customRC = ''
          source /home/traveller/.config/nvim/init.vim
        '';
      };
    })
  ];
}
