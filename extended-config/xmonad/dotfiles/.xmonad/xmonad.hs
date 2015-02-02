module Main where

import           Control.Applicative
import           Data.Monoid

import           XMonad
import           XMonad.Operations    (windows)
import qualified XMonad.StackSet      as W
import           XMonad.Util.EZConfig


-- Make changes to this file go live:
--     mod+q
--
-- If you need more error information:
--     $ xmonad --recompile


-- See this example config file for lots of good ideas:
--
--     https://github.com/vicfryzel/xmonad-config


-- For info on adding keybindings:
--
--     http://www.haskell.org/haskellwiki/Xmonad/General_xmonad.hs_config_tips#Adding_your_own_keybindings


hotkeysToWorkspaces =
  [ ("1", "1")
  , ("2", "2")
  , ("3", "3")
  , ("4", "4")
  , ("5", "5")
  , ("6", "6")
  , ("7", "7")
  , ("8", "8")
  , ("9", "9")
  , ("0", "0")
  ]

main = do
  xmonad $
    defaultConfig
      { borderWidth = 5
      , terminal = "urxvt"
      , workspaces = snd <$> hotkeysToWorkspaces
      }
    `additionalKeysP`
      ( [ ("M-s", spawn "screenshot")
        , ("M-e", spawn "screenshot-select")
        ]
      <>
        ((\(x,y) -> ("M-" <> x, windows $ W.view y)) <$> hotkeysToWorkspaces)
      <>
        ((\(x,y) -> ("M-S-" <> x, windows $ W.shift y)) <$> hotkeysToWorkspaces)
      )
