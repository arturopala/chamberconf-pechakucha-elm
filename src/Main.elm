module Main (..) where

import StartApp
import PechaKucha
import Time
import Keyboard
import Window
import Actions exposing (..)
import Task
import Effects exposing (Never)
import History


app =
    StartApp.start
        { init = PechaKucha.init
        , update = PechaKucha.update
        , view = PechaKucha.view
        , inputs =
            [ -- Every second signal a clock tick
              Signal.map (\_ -> Tick) (Time.fps PechaKucha.fps)
            , -- Catch key presses
              Signal.map Actions.keypressAsAction Keyboard.presses
            , -- Catch arrow press
              Signal.map Actions.arrowAsAction Keyboard.arrows
              -- Catch url hash history
            , Signal.map Actions.hashAsAction History.hash
            ]
        }


main =
    app.html


port tasks : Signal (Task.Task Never ())
port tasks =
    app.tasks
