module PechaKucha.Actions (..) where

import Char exposing (KeyCode)


type Action
    = Noop
    | PreviousPage
    | NextPage
    | Tick
    | Run
    | Pause
    | KeyPressed Int
    | Scene Int
    | UrlHash String


arrowAsAction : { x : Int, y : Int } -> Action
arrowAsAction { x, y } =
    if x == 1 then
        NextPage
    else if x == -1 then
        PreviousPage
    else
        Noop
