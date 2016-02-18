module PechaKucha.Page02 (Model, init, update, view) where

import Html exposing (..)
import Html.Attributes exposing (class, classList, style, key)
import PechaKucha.PageType1
import Actions exposing (..)


-- SCENES


scene0 : Html
scene0 =
    div
        [ class "scene0", key "s0.0" ]
        [ text "Elm promises" ]


scene1 : Html
scene1 =
    div
        [ class "scene1 orange animated fadeIn", key "s0.1" ]
        [ text "shockingly fast" ]


scene2 : Html
scene2 =
    div
        [ class "scene2 green  animated fadeIn", key "s0.2" ]
        [ text "nicely modular" ]


scene3 : Html
scene3 =
    div
        [ class "scene3 pink animated fadeIn", key "s0.3" ]
        [ text "easy to test" ]


scene4 : Html
scene4 =
    div
        [ class "scene4 blue animated fadeIn", key "s0.4" ]
        [ text "refactor and debug" ]



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
