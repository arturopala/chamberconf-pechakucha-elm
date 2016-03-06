module PechaKucha.Footer (..) where

import Html exposing (..)
import Html.Attributes exposing (class, classList, style)
import Html.Events exposing (..)
import PechaKucha.Config exposing (..)
import PechaKucha.Model exposing (..)
import PechaKucha.Actions exposing (..)


view address model =
    let
        page = indexLens.get model
    in
        div
            [ class "footer" ]
            [ span [] [ text "PechaKucha by Artur Opala, 2016 | page " ]
            , span [ class "green" ] [ text (page + 1 |> toString) ]
            , span [] [ text " | left " ]
            , span [ class "blue" ] [ text (toString (400 - (page * 20 + (model.clock // fps)))) ]
            , span [] [ text " sec | Built with Elm !" ]
            ]
