module PechaKucha.Overlay (..) where

import Effects exposing (Effects, map, batch, Never)
import Html exposing (..)
import Html.Attributes exposing (class, classList, style)
import Html.Events exposing (..)
import String exposing (length)
import Char
import Debug
import Task
import Array exposing (Array)
import PechaKucha.Actions exposing (..)
import Monocle.Lens exposing (Lens, compose)
import Graphics.Collage exposing (collage, group, outlined, toForm, rotate, square, filled, traced, path, LineStyle, alpha, solid, circle, defaultLine)
import Graphics.Element exposing (..)
import Text
import Color
import Result
import Maybe
import PechaKucha.Config exposing (..)
import PechaKucha.Model exposing (..)
import PechaKucha.Actions exposing (..)


clockLineStyle =
    { defaultLine | color = Color.gray, width = 10 }


opacityStep =
    0.3 / (5 * fps)


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
            clock address model


clock : Signal.Address Action -> Model -> Html
clock address model =
    let
        angle = degrees (toFloat ((-360 // pageTimeout) * ((model.clock // fps))))
    in
        div
            [ class "clock"
            , onClick address Pause
            ]
            [ fromElement
                (collage
                    240
                    240
                    [ alpha
                        0.1
                        (group
                            [ outlined clockLineStyle (circle 100)
                            , rotate
                                angle
                                (traced clockLineStyle (path [ ( 0, 0 ), ( 0, 95 ) ]))
                            ]
                        )
                    ]
                )
            ]
