module PechaKucha.Page15 (Model, init, update, view) where

import Html exposing (..)
import Html.Attributes exposing (class, classList, style, key)
import PechaKucha.PageType1
import PechaKucha.Actions exposing (..)


-- SCENES


scene0 : Html
scene0 =
    span
        [ class "scene0", key "s0.0" ]
        [ text "update" ]


scene1 : Html
scene1 =
    span
        [ class "scene1 orange animated fadeIn", key "s0.1" ]
        [ text ": action" ]


scene2 : Html
scene2 =
    span
        [ class "scene2 green  animated fadeIn", key "s0.2" ]
        [ text " -> model" ]


scene3 : Html
scene3 =
    div
        [ class "scene3 offset pink animated fadeIn", key "s0.3" ]
        [ text "-> (model" ]


scene4 : Html
scene4 =
    div
        [ class "scene4 offset blue animated fadeIn", key "s0.4" ]
        [ text ", Effects action)" ]



-- VIEW


view : Signal.Address Action -> Model -> Html
view address model =
    case model.scene of
        1 ->
            div [] [ scene0, scene1 ]

        2 ->
            div [] [ scene0, scene1, scene2 ]

        3 ->
            div [] [ scene0, scene1, scene2, scene3 ]

        4 ->
            div [] [ scene0, scene1, scene2, scene3, scene4 ]

        _ ->
            div [] [ scene0 ]



-- MODEL


type alias Model =
    PechaKucha.PageType1.Model


init =
    PechaKucha.PageType1.init


update =
    PechaKucha.PageType1.update
