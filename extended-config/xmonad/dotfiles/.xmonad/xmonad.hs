{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses, DeriveDataTypeable #-}
{-# LANGUAGE PatternGuards #-}
-- TODO: remove pragmas when the new XMonad.Layout.Spacing reaches hackage (xmonad-contrib 0.12)
-- it includes spacingWithEdge

module Main where

import           Control.Applicative
import           Data.Monoid

import           XMonad
import           XMonad.Hooks.ManageDocks
import           XMonad.Layout.NoBorders
import           XMonad.Operations        (windows)
import qualified XMonad.StackSet          as W
import           XMonad.Util.EZConfig

-- import XMonad.Layout.Spacing

-- TODO: remove all these when spacingWithEdge hits hackage
import Graphics.X11 (Rectangle(..))
import Control.Arrow (second)
import XMonad.Operations (sendMessage)
import XMonad.Core (X,runLayout,Message,fromMessage,Typeable)
import XMonad.StackSet (up, down, Workspace(..))
import XMonad.Util.Font (fi)
import XMonad.Layout.LayoutModifier

-- Make changes to this file go live:
--     mod+q
--
-- If you need more error information:
--     $ xmonad --recompile


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
      { borderWidth = 1
      , layoutHook  = myLayout
      , terminal    = "urxvt"
      , workspaces  = snd <$> hotkeysToWorkspaces
      }
    `additionalKeysP`
      (  [ ("M-s", spawn "screenshot")
         , ("M-e", spawn "screenshot-select")
         ]
      <> ((\(x,y) -> ("M-" <> x, windows $ W.view y)) <$> hotkeysToWorkspaces)
      <> ((\(x,y) -> ("M-S-" <> x, windows $ W.shift y)) <$> hotkeysToWorkspaces)
      )
























-- TODO: remove all the below when spacingWithEdge hits hackage

-- $usage
-- You can use this module by importing it into your @~\/.xmonad\/xmonad.hs@ file:
--
-- > import XMonad.Layout.Spacing
--
-- and modifying your layoutHook as follows (for example):
--
-- > layoutHook = spacing 2 $ Tall 1 (3/100) (1/2)
-- >                      -- put a 2px space around every window
--

-- | Surround all windows by a certain number of pixels of blank space.
spacing :: Int -> l a -> ModifiedLayout Spacing l a
spacing p = ModifiedLayout (Spacing p)

data Spacing a = Spacing Int deriving (Show, Read)

-- | Message to dynamically modify (e.g. increase/decrease/set) the size of the window spacing
data ModifySpacing = ModifySpacing (Int -> Int) deriving (Typeable)
instance Message ModifySpacing

-- | Set spacing to given amount
setSpacing :: Int -> X ()
setSpacing n = sendMessage $ ModifySpacing $ const n

-- | Increase spacing by given amount
incSpacing :: Int -> X ()
incSpacing n = sendMessage $ ModifySpacing $ (+n)

instance LayoutModifier Spacing a where

    pureModifier (Spacing p) _ _ wrs = (map (second $ shrinkRect p) wrs, Nothing)

    pureMess (Spacing px) m
     | Just (ModifySpacing f) <- fromMessage m = Just $ Spacing $ max 0 $ f px
     | otherwise = Nothing

    modifierDescription (Spacing p) = "Spacing " ++ show p

-- | Surround all windows by a certain number of pixels of blank space, and
-- additionally adds the same amount of spacing around the edge of the screen.
spacingWithEdge :: Int -> l a -> ModifiedLayout SpacingWithEdge l a
spacingWithEdge p = ModifiedLayout (SpacingWithEdge p)

data SpacingWithEdge a = SpacingWithEdge Int deriving (Show, Read)

instance LayoutModifier SpacingWithEdge a where

    pureModifier (SpacingWithEdge p) _ _ wrs = (map (second $ shrinkRect p) wrs, Nothing)

    pureMess (SpacingWithEdge px) m
     | Just (ModifySpacing f) <- fromMessage m = Just $ SpacingWithEdge $ max 0 $ f px
     | otherwise = Nothing

    modifyLayout (SpacingWithEdge p) w r = runLayout w (shrinkRect p r)

    modifierDescription (SpacingWithEdge p) = "SpacingWithEdge " ++ show p

shrinkRect :: Int -> Rectangle -> Rectangle
shrinkRect p (Rectangle x y w h) = Rectangle (x+fi p) (y+fi p) (w-2*fi p) (h-2*fi p)

-- | Surrounds all windows with blank space, except when the window is the only
-- visible window on the current workspace.
smartSpacing :: Int -> l a -> ModifiedLayout SmartSpacing l a
smartSpacing p = ModifiedLayout (SmartSpacing p)

data SmartSpacing a = SmartSpacing Int deriving (Show, Read)

instance LayoutModifier SmartSpacing a where

    pureModifier _ _ _ [x] = ([x], Nothing)
    pureModifier (SmartSpacing p) _ _ wrs = (map (second $ shrinkRect p) wrs, Nothing)

    modifierDescription (SmartSpacing p) = "SmartSpacing " ++ show p

-- | Surrounds all windows with blank space, and adds the same amount of spacing
-- around the edge of the screen, except when the window is the only visible
-- window on the current workspace.
smartSpacingWithEdge :: Int -> l a -> ModifiedLayout SmartSpacingWithEdge l a
smartSpacingWithEdge p = ModifiedLayout (SmartSpacingWithEdge p)

data SmartSpacingWithEdge a = SmartSpacingWithEdge Int deriving (Show, Read)

instance LayoutModifier SmartSpacingWithEdge a where

    pureModifier _ _ _ [x] = ([x], Nothing)
    pureModifier (SmartSpacingWithEdge p) _ _ wrs = (map (second $ shrinkRect p) wrs, Nothing)

    modifyLayout (SmartSpacingWithEdge p) w r
        | maybe False (\s -> null (up s) && null (down s)) (stack w) = runLayout w r
        | otherwise = runLayout w (shrinkRect p r)

    modifierDescription (SmartSpacingWithEdge p) = "SmartSpacingWithEdge " ++ show p
