module Main (..) where

import StartApp
import Time
import Keyboard
import Window
import PechaKucha.Actions exposing (..)
import Task
import Effects exposing (Never)
import History
import PechaKucha
import PechaKucha.Config


app =
    StartApp.start
        { init = PechaKucha.init
        , update = PechaKucha.update
        , view = PechaKucha.view
        , inputs =
            [ -- Every second signal a clock tick
              Signal.map (\_ -> Tick) (Time.fps PechaKucha.Config.fps)
            , -- Catch key presses
              Signal.map KeyPressed Keyboard.presses
            , -- Catch arrow press
              Signal.map PechaKucha.Actions.arrowAsAction Keyboard.arrows
              -- Catch url hash history
            , Signal.map UrlHash History.hash
            ]
        }


main =
    app.html


port tasks : Signal (Task.Task Never ())
port tasks =
    app.tasks
