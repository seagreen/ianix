{-# LANGUAGE OverloadedStrings #-}

-- | Make changes to this file go live (by recompiling and restarting):
--     mod+q
--
-- If you need more error information (NOTE: This doesn't make changes go live):
--     $ xmonad --recompile
--
-- mod+q is handled in the source code here:
--
--     https://github.com/xmonad/xmonad/blob/bb13853929f8f6fc59b526bcc10631e1bac309ad/src/XMonad/Config.hs#L222

module Main where

import           Data.ByteString          (ByteString)
import qualified Data.ByteString          as BS
import           Data.Monoid
import           System.Directory         (doesFileExist)

import           XMonad
import           XMonad.Config            (defaultConfig)
import           XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook)
import           XMonad.Layout.NoBorders  (noBorders)
import           XMonad.Layout.Spacing    (spacingWithEdge)
import           XMonad.Operations        (windows)
import qualified XMonad.StackSet          as W
import           XMonad.Util.EZConfig     (additionalKeysP)

-- | 'avoidStruts' prevents windows from overlaying xmobar.
myLayout =
      -- Vertical split with room between windows and for xmobar.
      avoidStruts (spacingWithEdge 5 tiled)

      -- Vertical split.
  ||| tiled

      -- Horizontal split with room between windows and for xmobar.
  ||| avoidStruts (spacingWithEdge 5 (Mirror tiled))

      -- One window fullscreen, others hidden.
  ||| noBorders Full
  where
    -- Default tiling algorithm partitions the screen into two panes.
    tiled = Tall nmaster delta ratio
      where
        -- The default number of windows in the master pane.
        nmaster = 1
        -- Default proportion of screen occupied by master pane.
        ratio = 1/2
        -- Percent of screen to increment by when resizing panes.
        delta = 3/100

-- | Made explicit because 'docksEventHook' is required to make 'avoidStruts'
-- work for window 1 specifically, see this issue:
--
-- https://github.com/xmonad/xmonad/issues/15
myEventHook :: Event -> X All
myEventHook = docksEventHook <> handleEventHook defaultConfig

hotkeysToWorkspaces :: [(String, WorkspaceId)]
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

myConfig =
  defaultConfig
    { borderWidth     = 1
    , layoutHook      = myLayout
    , modMask         = mod4Mask -- super (command or ⌘ on macOS)
    , handleEventHook = myEventHook
    , terminal        = "alacritty --command fish"
    , workspaces      = snd <$> hotkeysToWorkspaces
    }
  `additionalKeysP`
      (  [ ("M-s", spawn "screenshot")
         , ("M-e", spawn "screenshot-select")

         , ("M-b", spawn "urxvt -e sh") -- Backup in case normal terminal isn't working.
         ]
         -- @W.greedyView@ means that if you have two monitors A and B with
         -- A focused and workspace 2 open in B, and you switch to
         -- workspace 2, the workspaces will switch so that 2 is now
         -- shown in monitor A.
         --
         -- This is usually better if you have a central, main monitor.
         -- If you're using multiple monitors equally you may want
         -- @W.view@.
      <> ((\(x,y) -> ("M-" <> x, windows (W.greedyView y))) <$> hotkeysToWorkspaces)
      <> ((\(x,y) -> ("M-S-" <> x, windows (W.shift y))) <$> hotkeysToWorkspaces)
      )

main :: IO ()
main = xmonad myConfig
