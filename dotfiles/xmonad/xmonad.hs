import XMonad

import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig


-- Make changes to this file go live:
--
-- $ xmonad --recompile
-- mod+q


-- See this example config file for lots of good ideas:
--
--     https://github.com/vicfryzel/xmonad-config


-- For info on adding keybindings:
--
--     http://www.haskell.org/haskellwiki/Xmonad/General_xmonad.hs_config_tips#Adding_your_own_keybindings


main = do
    xmonad $
        defaultConfig
            { terminal = "urxvt"
            }
        `additionalKeysP`
            [ ("M-s", spawn "screenshot")
            , ("M-s-e", spawn "screenshot-select")
            ]
