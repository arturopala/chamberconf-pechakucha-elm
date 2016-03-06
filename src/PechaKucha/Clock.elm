module PechaKucha.Clock (..) where

import Effects exposing (Effects, map, batch, Never)
import Html exposing (..)
import Html.Attributes exposing (class, classList, style)
import Html.Events exposing (..)
import Graphics.Collage exposing (collage, group, outlined, toForm, rotate, square, filled, traced, path, LineStyle, alpha, solid, circle, defaultLine)
import Graphics.Element exposing (..)
import Text
import Color
import Result
import Maybe


type Action
    = Pause


type alias Config =
    { size : Int
    , border : Int
    , lineStyle : Graphics.Collage.LineStyle
    , opacity : Float
    }


clock : Signal.Address Action -> Config -> Float -> Html
clock address config angle =
    let
        radius = (toFloat config.size) / 2

        width = config.size + config.border * 2

        height = config.size + config.border * 2
    in
        div
            [ class "clock"
            , onClick address Pause
            ]
            [ fromElement
                (collage
                    width
                    height
                    [ alpha
                        config.opacity
                        (group
                            [ outlined config.lineStyle (circle radius)
                            , rotate
                                angle
                                (traced config.lineStyle (path [ ( 0, 0 ), ( 0, radius - config.lineStyle.width ) ]))
                            ]
                        )
                    ]
                )
            ]
