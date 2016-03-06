module PechaKucha.PageType1 (..) where

import PechaKucha.Actions exposing (..)
import Effects exposing (Effects, map, batch, Never)


-- MODEL


type alias Model =
    { scene : Int, frame : Int }


init : ( Model, Effects Action )
init =
    ( Model 0 0, Effects.none )



-- UPDATE


update : Action -> Model -> ( Model, Effects Action )
update message model =
    case message of
        Tick ->
            ( { model | frame = model.frame + 1 }, Effects.none )

        Scene n ->
            ( { model | scene = n }, Effects.none )

        _ ->
            ( model, Effects.none )
