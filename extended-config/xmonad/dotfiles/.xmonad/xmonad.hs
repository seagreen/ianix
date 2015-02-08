module Main where

import           Control.Applicative
import           Data.Monoid

import           XMonad
import           XMonad.Layout.NoBorders
import           XMonad.Operations    (windows)
import qualified XMonad.StackSet      as W
import           XMonad.Util.EZConfig

-- Make changes to this file go live:
--     mod+q
--
-- If you need more error information:
--     $ xmonad --recompile


-- | The available layouts. Note that each layout is separated by |||,
-- which denotes layout choice.
myLayout = tiled ||| Mirror tiled ||| noBorders Full
  where
    -- Default tiling algorithm partitions the screen into two panes.
    tiled = Tall nmaster delta ratio
    -- The default number of windows in the master pane.
    nmaster = 1
    -- Default proportion of screen occupied by master pane.
    ratio = 1/2
    -- Percent of screen to increment by when resizing panes.
    delta = 3/100

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
      , layoutHook = myLayout
      , terminal = "urxvt"
      , workspaces = snd <$> hotkeysToWorkspaces
      -- , normalBorderColor = "#7c7c7c"
      -- , focusedBorderColor = "#ffb6b0"
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
