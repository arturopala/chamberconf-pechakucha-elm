module PechaKucha.Config (..) where

import Color
import PechaKucha.Clock
import Graphics.Collage exposing (defaultLine)


fps =
    1


pageTimeout =
    20


pageFrames =
    pageTimeout * fps


roundFrames =
    (pageTimeout // 5) * fps


initialDelay =
    2 * fps


clockConfig : PechaKucha.Clock.Config
clockConfig =
    { size = 180
    , border = 20
    , lineStyle = { defaultLine | color = Color.gray, width = 10 }
    , opacity = 0.1
    }
