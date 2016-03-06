module PechaKucha.Model (..) where

import Effects exposing (Effects, map, batch, Never)
import Monocle.Lens exposing (Lens, compose)
import PechaKucha.Config exposing (..)
import PechaKucha.Actions exposing (..)
import PechaKucha.Pages


type PresentationState
    = Idle
    | Paused
    | Running
    | Terminated


type alias Model =
    { clock : Int
    , pages : PechaKucha.Pages.Model
    , state : PresentationState
    , delayed : Int
    }


clockLens =
    Lens .clock (\x m -> { m | clock = x })


delayedLens =
    Lens .delayed (\x m -> { m | delayed = x })


pagesLens =
    Lens .pages (\x m -> { m | pages = x })


indexLens =
    pagesLens `compose` PechaKucha.Pages.indexLens


windowLens =
    Lens .window (\x m -> { m | window = x })


stateLens =
    Lens .state (\x m -> { m | state = x })
