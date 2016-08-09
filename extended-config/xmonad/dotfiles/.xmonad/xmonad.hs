-- | Make changes to this file go live:
--     mod+q
--
-- If you need more error information:
--     $ xmonad --recompile

module Main where

import           Data.Monoid

import           XMonad
import           XMonad.Config            (defaultConfig)
import           XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook)
import           XMonad.Layout.NoBorders  (noBorders)
import           XMonad.Layout.Spacing    (spacingWithEdge)
import           XMonad.Operations        (windows)
import qualified XMonad.StackSet          as W
import           XMonad.Util.EZConfig     (additionalKeysP)

-- | The available layouts. Note that each layout is separated by |||,
-- which denotes layout choice.
myLayout = avoidStruts (spacingWithEdge 5 tiled)
       ||| tiled
       ||| avoidStruts (spacingWithEdge 5 (Mirror tiled))
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
        , handleEventHook = myEventHook
        , terminal        = "urxvt"
        , workspaces      = snd <$> hotkeysToWorkspaces
        }
    `additionalKeysP`
        (  [ ("M-s", spawn "screenshot")
           , ("M-e", spawn "screenshot-select")
           ]
        <> ((\(x,y) -> ("M-" <> x, windows $ W.view y)) <$> hotkeysToWorkspaces)
        <> ((\(x,y) -> ("M-S-" <> x, windows $ W.shift y)) <$> hotkeysToWorkspaces)
        )

main :: IO ()
main = xmonad myConfig
