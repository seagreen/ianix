{-# LANGUAGE OverloadedStrings #-}

-- | Make changes to this file go live:
--     mod+q
--
-- If you need more error information (NOTE: This doesn't make changes go live):
--     $ xmonad --recompile

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

myConfig comp =
    defaultConfig
        { borderWidth     = 1
        , layoutHook      = myLayout
        , modMask         = case comp of
                                MacLaptop -> mod4Mask -- command / ⌘
                                OtherComp -> mod1Mask -- alt (default)
        , handleEventHook = myEventHook
        , terminal        = "urxvt"
        , workspaces      = snd <$> hotkeysToWorkspaces
        }
    `additionalKeysP`
        (  [ ("M-s", spawn "screenshot")
           , ("M-e", spawn "screenshot-select")
           ]
           -- @W.greedyView@ means that if you have two monitors A and B with
           -- A focused and workspace 2 open in B, and you switch to
           -- workspace 2, the workspaces will switch so that 2 is now
           -- shown in monitor A.
           --
           -- This is usually better if you have a central, main monitor.
           -- If you're using multiple monitors equally you may want
           -- @W.view@.
        <> ((\(x,y) -> ("M-" <> x, windows $ W.greedyView y)) <$> hotkeysToWorkspaces)
        <> ((\(x,y) -> ("M-S-" <> x, windows $ W.shift y)) <$> hotkeysToWorkspaces)
        )

-- | So we can give my laptop a different mod key.
data Computer
    = MacLaptop
    | OtherComp
    deriving (Eq, Show)

getComp :: IO Computer
getComp = do
    let infoFile = "/etc/nixos/computer"
    exists <- doesFileExist infoFile
    if exists
        then btsToComp <$> BS.readFile infoFile
        else pure OtherComp
  where
    btsToComp :: ByteString -> Computer
    btsToComp "maclaptop\n" = MacLaptop
    btsToComp _ = OtherComp

main :: IO ()
main = do
    comp <- getComp
    xmonad (myConfig comp)
