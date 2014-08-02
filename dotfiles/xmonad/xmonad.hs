import XMonad

-- $ xmonad --recompile
-- mod+q

main = do
    xmonad $ defaultConfig
      { terminal = "urxvt"
      }
