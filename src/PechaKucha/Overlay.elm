module PechaKucha.Overlay (..) where

import Effects exposing (Effects, map, batch, Never)
import Html exposing (..)
import Html.Attributes exposing (class, classList, style)
import Html.Events exposing (..)
import String exposing (length)
import Result
import Maybe
import PechaKucha.Config exposing (..)
import PechaKucha.Model exposing (..)
import PechaKucha.Actions exposing (..)
import PechaKucha.Actions exposing (..)
import PechaKucha.Clock exposing (clock)


view : Signal.Address Action -> Model -> Html
view address model =
    case model.state of
        Idle ->
            div
                [ class "overlay"
                , onClick address Run
                ]
                [ span [ class "fa fa-play" ] []
                ]

        Paused ->
            div
                [ class "overlay"
                , onClick address Run
                ]
                [ span [ class "fa fa-pause" ] []
                ]

        Terminated ->
            div
                [ class "overlay"
                , onClick address Run
                ]
                [ span [ class "fa fa-refresh" ] []
                ]

        Running ->
            let
                angle = degrees (toFloat ((-360 // pageTimeout) * ((model.clock // fps))))
            in
                clock (Signal.forwardTo address (\_ -> Pause)) clockConfig angle
