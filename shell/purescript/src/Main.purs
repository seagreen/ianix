module Main where

import Control.Monad.Eff (Eff)
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Types (ALERT)
import DOM.HTML.Window (alert)
import Prelude

hello :: String
hello = "Hello world."

main :: ∀ a. Eff ( dom :: DOM, alert :: ALERT | a) Unit
main = window >>= alert hello
