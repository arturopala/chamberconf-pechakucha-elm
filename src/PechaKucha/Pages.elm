module PechaKucha.Pages (Model, init, update, view, indexLens, maxPageIndex, minPageIndex) where

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
import Monocle.Lens exposing (Lens, zip, compose, modify, modifyAndMerge)
import PechaKucha.Page01
import PechaKucha.Page02
import PechaKucha.Page03
import PechaKucha.Page04
import PechaKucha.Page05
import PechaKucha.Page06
import PechaKucha.Page07
import PechaKucha.Page08
import PechaKucha.Page09
import PechaKucha.Page10
import PechaKucha.Page11
import PechaKucha.Page12
import PechaKucha.Page13
import PechaKucha.Page14
import PechaKucha.Page15
import PechaKucha.Page16
import PechaKucha.Page17
import PechaKucha.Page18
import PechaKucha.Page19
import PechaKucha.Page20


-- MODEL


minPageIndex =
    0


maxPageIndex =
    19


type alias Model =
    { currentPageIndex : Int
    , page01 : PechaKucha.Page01.Model
    , page02 : PechaKucha.Page02.Model
    , page03 : PechaKucha.Page03.Model
    , page04 : PechaKucha.Page04.Model
    , page05 : PechaKucha.Page05.Model
    , page06 : PechaKucha.Page06.Model
    , page07 : PechaKucha.Page07.Model
    , page08 : PechaKucha.Page08.Model
    , page09 : PechaKucha.Page09.Model
    , page10 : PechaKucha.Page10.Model
    , page11 : PechaKucha.Page11.Model
    , page12 : PechaKucha.Page12.Model
    , page13 : PechaKucha.Page13.Model
    , page14 : PechaKucha.Page14.Model
    , page15 : PechaKucha.Page15.Model
    , page16 : PechaKucha.Page16.Model
    , page17 : PechaKucha.Page17.Model
    , page18 : PechaKucha.Page18.Model
    , page19 : PechaKucha.Page19.Model
    , page20 : PechaKucha.Page20.Model
    }


init : ( Model, Effects Action )
init =
    let
        ( page01, e01 ) = PechaKucha.Page01.init

        ( page02, e02 ) = PechaKucha.Page02.init

        ( page03, e03 ) = PechaKucha.Page03.init

        ( page04, e04 ) = PechaKucha.Page04.init

        ( page05, e05 ) = PechaKucha.Page05.init

        ( page06, e06 ) = PechaKucha.Page06.init

        ( page07, e07 ) = PechaKucha.Page07.init

        ( page08, e08 ) = PechaKucha.Page08.init

        ( page09, e09 ) = PechaKucha.Page09.init

        ( page10, e10 ) = PechaKucha.Page10.init

        ( page11, e11 ) = PechaKucha.Page11.init

        ( page12, e12 ) = PechaKucha.Page12.init

        ( page13, e13 ) = PechaKucha.Page13.init

        ( page14, e14 ) = PechaKucha.Page14.init

        ( page15, e15 ) = PechaKucha.Page15.init

        ( page16, e16 ) = PechaKucha.Page16.init

        ( page17, e17 ) = PechaKucha.Page17.init

        ( page18, e18 ) = PechaKucha.Page18.init

        ( page19, e19 ) = PechaKucha.Page19.init

        ( page20, e20 ) = PechaKucha.Page20.init
    in
        ( { currentPageIndex = 0
          , page01 = page01
          , page02 = page02
          , page03 = page03
          , page04 = page04
          , page05 = page05
          , page06 = page06
          , page07 = page07
          , page08 = page08
          , page09 = page09
          , page10 = page10
          , page11 = page11
          , page12 = page12
          , page13 = page13
          , page14 = page14
          , page15 = page15
          , page16 = page16
          , page17 = page17
          , page18 = page18
          , page19 = page19
          , page20 = page20
          }
        , Effects.batch [ e01, e02, e03, e04, e05, e06, e07, e08, e09, e10, e11, e12, e13, e14, e15, e16, e17, e18, e19, e20 ]
        )


indexLens =
    Lens .currentPageIndex (\x m -> { m | currentPageIndex = x })


page01Lens =
    Lens .page01 (\x m -> { m | page01 = x })


page02Lens =
    Lens .page02 (\x m -> { m | page02 = x })


page03Lens =
    Lens .page03 (\x m -> { m | page03 = x })


page04Lens =
    Lens .page04 (\x m -> { m | page04 = x })


page05Lens =
    Lens .page05 (\x m -> { m | page05 = x })


page06Lens =
    Lens .page06 (\x m -> { m | page06 = x })


page07Lens =
    Lens .page07 (\x m -> { m | page07 = x })


page08Lens =
    Lens .page08 (\x m -> { m | page08 = x })


page09Lens =
    Lens .page09 (\x m -> { m | page09 = x })


page10Lens =
    Lens .page10 (\x m -> { m | page10 = x })


page11Lens =
    Lens .page11 (\x m -> { m | page11 = x })


page12Lens =
    Lens .page12 (\x m -> { m | page12 = x })


page13Lens =
    Lens .page13 (\x m -> { m | page13 = x })


page14Lens =
    Lens .page14 (\x m -> { m | page14 = x })


page15Lens =
    Lens .page15 (\x m -> { m | page15 = x })


page16Lens =
    Lens .page16 (\x m -> { m | page16 = x })


page17Lens =
    Lens .page17 (\x m -> { m | page17 = x })


page18Lens =
    Lens .page18 (\x m -> { m | page18 = x })


page19Lens =
    Lens .page19 (\x m -> { m | page19 = x })


page20Lens =
    Lens .page20 (\x m -> { m | page20 = x })



-- UPDATE


updatePage : Lens Model model -> (Action -> model -> ( model, Effects Action )) -> Action -> Model -> ( Model, Effects Action )
updatePage lens update action model =
    lens.get model |> update action |> (\( m, e ) -> ( lens.set m model, e ))


updatePageN : Int -> Action -> Model -> ( Model, Effects Action )
updatePageN index =
    case (index + 1) of
        1 ->
            updatePage page01Lens PechaKucha.Page01.update

        2 ->
            updatePage page02Lens PechaKucha.Page02.update

        3 ->
            updatePage page03Lens PechaKucha.Page03.update

        4 ->
            updatePage page04Lens PechaKucha.Page04.update

        5 ->
            updatePage page05Lens PechaKucha.Page05.update

        6 ->
            updatePage page06Lens PechaKucha.Page06.update

        7 ->
            updatePage page07Lens PechaKucha.Page07.update

        8 ->
            updatePage page08Lens PechaKucha.Page08.update

        9 ->
            updatePage page09Lens PechaKucha.Page09.update

        10 ->
            updatePage page10Lens PechaKucha.Page10.update

        11 ->
            updatePage page11Lens PechaKucha.Page11.update

        12 ->
            updatePage page12Lens PechaKucha.Page12.update

        13 ->
            updatePage page13Lens PechaKucha.Page13.update

        14 ->
            updatePage page14Lens PechaKucha.Page14.update

        15 ->
            updatePage page15Lens PechaKucha.Page15.update

        16 ->
            updatePage page16Lens PechaKucha.Page16.update

        17 ->
            updatePage page17Lens PechaKucha.Page17.update

        18 ->
            updatePage page18Lens PechaKucha.Page18.update

        19 ->
            updatePage page19Lens PechaKucha.Page19.update

        n ->
            updatePage page20Lens PechaKucha.Page20.update


update : Action -> Model -> ( Model, Effects Action )
update action model =
    updatePageN model.currentPageIndex action model



-- VIEW


viewPage : Lens Model model -> (Signal.Address Action -> model -> Html) -> Signal.Address Action -> Model -> Html
viewPage lens view address model =
    lens.get model |> view address


viewPageN : Int -> Signal.Address Action -> Model -> Html
viewPageN index =
    case (index + 1) of
        1 ->
            viewPage page01Lens PechaKucha.Page01.view

        2 ->
            viewPage page02Lens PechaKucha.Page02.view

        3 ->
            viewPage page03Lens PechaKucha.Page03.view

        4 ->
            viewPage page04Lens PechaKucha.Page04.view

        5 ->
            viewPage page05Lens PechaKucha.Page05.view

        6 ->
            viewPage page06Lens PechaKucha.Page06.view

        7 ->
            viewPage page07Lens PechaKucha.Page07.view

        8 ->
            viewPage page08Lens PechaKucha.Page08.view

        9 ->
            viewPage page09Lens PechaKucha.Page09.view

        10 ->
            viewPage page10Lens PechaKucha.Page10.view

        11 ->
            viewPage page11Lens PechaKucha.Page11.view

        12 ->
            viewPage page12Lens PechaKucha.Page12.view

        13 ->
            viewPage page13Lens PechaKucha.Page13.view

        14 ->
            viewPage page14Lens PechaKucha.Page14.view

        15 ->
            viewPage page15Lens PechaKucha.Page15.view

        16 ->
            viewPage page16Lens PechaKucha.Page16.view

        17 ->
            viewPage page17Lens PechaKucha.Page17.view

        18 ->
            viewPage page18Lens PechaKucha.Page18.view

        19 ->
            viewPage page19Lens PechaKucha.Page19.view

        n ->
            viewPage page20Lens PechaKucha.Page20.view


view : Signal.Address Action -> Model -> Html
view address model =
    viewPageN model.currentPageIndex address model
