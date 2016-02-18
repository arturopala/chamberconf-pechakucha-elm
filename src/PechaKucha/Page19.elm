module PechaKucha.Page19 (Model, init, update, view) where

import Html exposing (..)
import Html.Attributes exposing (class, classList, style, key)
import PechaKucha.PageType1
import Actions exposing (..)


-- SCENES


scene00 : Html
scene00 =
    div
        [ class "scene0", key "s0.0" ]
        [ text "hello world!" ]


scene0 : Html
scene0 =
    div
        [ class "scene0", key "s0.0" ]
        [ span [ class "midi" ] [ text "" ]
        , span [] [ text "app = " ]
        , span [ class "medium" ] [ text "StartApp.start" ]
        ]


scene1 : Html
scene1 =
    div
        [ class "scene1 medium offset orange animated fadeIn", key "s0.1" ]
        [ span [] [ text " { init = ... , update = ..." ]
        , span [ class "tiny" ] [ text "" ]
        ]


scene2 : Html
scene2 =
    div
        [ class "scene2 medium offset green  animated fadeIn", key "s0.2" ]
        [ span [] [ text ", view = ... , inputs = ... }" ]
        , span [ class "tiny" ] [ text "" ]
        ]


scene3 : Html
scene3 =
    div
        [ class "scene3 pink animated fadeIn", key "s0.3" ]
        [ span [] [ text "main = " ]
        , span [ class "medium" ] [ text "app.html" ]
        ]


scene4 : Html
scene4 =
    div
        [ class "scene4 blue animated fadeIn", key "s0.4" ]
        [ span [] [ text "port tasks = " ]
        , span [ class "medium" ] [ text "app.tasks" ]
        ]



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
            div [] [ scene00 ]



-- MODEL


type alias Model =
    PechaKucha.PageType1.Model


init =
    PechaKucha.PageType1.init


update =
    PechaKucha.PageType1.update
