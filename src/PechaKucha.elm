module PechaKucha (..) where

import Effects exposing (Effects, map, batch, Never)
import Html exposing (..)
import Html.Attributes exposing (class, classList, style)
import Html.Events exposing (..)
import String exposing (length)
import Char
import Debug
import Task
import Array exposing (Array)
import Actions exposing (..)
import Monocle.Lens exposing (Lens, compose)
import Graphics.Collage exposing (collage, group, outlined, toForm, rotate, square, filled, traced, path, LineStyle, alpha, solid, circle, defaultLine)
import Graphics.Element exposing (..)
import PechaKucha.Pages
import Text
import Color
import Result
import Maybe
import History


-- MODEL


fps =
    1


pageTimeout =
    20


pageFrames =
    pageTimeout * fps


roundFrames =
    (pageTimeout // 5) * fps


initialDelay =
    2 * fps


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


init : ( Model, Effects Action )
init =
    let
        ( pages, effects ) = PechaKucha.Pages.init
    in
        ( { clock = 0
          , pages = pages
          , state = Idle
          , delayed = initialDelay
          }
        , Effects.batch [ effects ]
        )


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


tickClock : Model -> Model
tickClock =
    Monocle.Lens.modify clockLens (\t -> t + 1)


decrementDelay : Model -> Model
decrementDelay =
    Monocle.Lens.modify
        delayedLens
        (\t ->
            if t > 0 then
                t - 1
            else
                t
        )


resetClock : Model -> Model
resetClock =
    Monocle.Lens.modify clockLens (\t -> 0)
        >> Monocle.Lens.modify delayedLens (\d -> initialDelay)


forwardPage =
    Monocle.Lens.modify
        indexLens
        (\i -> i + 1)


rollbackPage =
    Monocle.Lens.modify
        indexLens
        (\i -> i - 1)


nextPage : Int -> Model -> Model
nextPage max model =
    if (indexLens.get model) < max then
        model |> forwardPage >> resetClock
    else
        model |> stateLens.set Terminated >> resetClock


previousPage : Int -> Model -> Model
previousPage min model =
    if (indexLens.get model) > min then
        model |> rollbackPage >> resetClock
    else
        model |> stateLens.set Idle >> resetClock



-- UPDATE


send : Action -> Effects Action
send action =
    Task.succeed action
        |> Effects.task


setHash n =
    let
        set = History.setPath ("/#" ++ (toString n))

        task = Task.andThen set (\_ -> Task.succeed Noop)
    in
        Effects.task task


none =
    Effects.none


receiveTickWhenRunning =
    tickClock
        >> (\m ->
                if m.clock >= pageFrames then
                    receiveNextPage m
                else if m.clock `rem` roundFrames == 0 then
                    ( m, send (Scene (m.clock // roundFrames)) )
                else
                    ( m, none )
           )


receiveTickOtherwise model =
    ( model |> decrementDelay, none )


receiveNextPage model =
    let
        updated = nextPage PechaKucha.Pages.maxPageIndex model

        effects = Effects.batch [ setHash (indexLens.get updated), send (Scene 0) ]
    in
        ( updated, effects )


receivePreviousPage model =
    let
        updated = previousPage PechaKucha.Pages.minPageIndex model

        effects = none
    in
        ( updated, effects )


receiveRun model =
    let
        effects =
            if model.clock == 0 then
                send (Scene 0)
            else
                none
    in
        ( stateLens.set Running model, effects )


receivePause model =
    ( stateLens.set Paused model |> delayedLens.set initialDelay, none )


receiveUrlHash hash model =
    let
        index =
            hash
                |> String.dropLeft 1
                |> String.toInt
                |> Result.toMaybe
    in
        case index of
            Just n ->
                ( model |> indexLens.set n |> clockLens.set 0, none )

            Nothing ->
                ( model, none )


mergeEffects a b =
    Effects.batch [ a, b ]


(>>>) : (Model -> ( Model, Effects Action )) -> (Model -> ( Model, Effects Action )) -> Model -> ( Model, Effects Action )
(>>>) left right =
    let
        merge e1 ( m2, e2 ) = ( m2, mergeEffects e1 e2 )

        r ( m1, e1 ) = right m1 |> merge e1

        l model = left model |> r
    in
        l


(|>>) : ( Model, Effects Action ) -> (Model -> ( Model, Effects Action )) -> ( Model, Effects Action )
(|>>) init right =
    let
        merge e1 ( m2, e2 ) = ( m2, mergeEffects e1 e2 )

        r ( m1, e1 ) = right m1 |> merge e1
    in
        r init


(||>) : ( Model, Effects Action ) -> Effects Action -> ( Model, Effects Action )
(||>) ( model, e1 ) e2 =
    ( model, Effects.batch [ e1, e2 ] )


updatePages : Action -> ( Model, Effects Action ) -> ( Model, Effects Action )
updatePages action =
    Monocle.Lens.modifyAndMerge pagesLens (PechaKucha.Pages.update action) mergeEffects


update : Action -> Model -> ( Model, Effects Action )
update action model =
    case model.state of
        Idle ->
            updateWhenIdle action model

        Paused ->
            updateWhenPaused action model

        Running ->
            updateWhenRunning action model |> updatePages action

        Terminated ->
            updateWhenTerminated action model


updateWhenIdle : Action -> Model -> ( Model, Effects Action )
updateWhenIdle action model =
    case action of
        NextPage ->
            model |> receivePause >>> receiveNextPage

        _ ->
            updateModel action model


updateWhenPaused : Action -> Model -> ( Model, Effects Action )
updateWhenPaused action model =
    case action of
        Tick ->
            receiveTickOtherwise model

        NextPage ->
            model |> receiveNextPage

        PreviousPage ->
            model |> receivePreviousPage

        _ ->
            updateModel action model


updateWhenRunning : Action -> Model -> ( Model, Effects Action )
updateWhenRunning action model =
    case action of
        Tick ->
            receiveTickWhenRunning model

        NextPage ->
            model |> receivePause >>> receiveNextPage

        PreviousPage ->
            model |> receivePause >>> receivePreviousPage

        Pause ->
            receivePause model

        KeyPressed 32 ->
            receivePause model

        _ ->
            updateModel action model


updateWhenTerminated : Action -> Model -> ( Model, Effects Action )
updateWhenTerminated action model =
    case action of
        Tick ->
            receiveTickOtherwise model

        Run ->
            init |>> receiveRun

        KeyPressed 13 ->
            init |>> receiveRun

        PreviousPage ->
            model |> receivePause >>> receivePreviousPage

        _ ->
            updateModel action model


updateModel : Action -> Model -> ( Model, Effects Action )
updateModel action model =
    case action of
        Run ->
            receiveRun model

        KeyPressed 32 ->
            receiveRun model

        KeyPressed 13 ->
            receiveRun model

        UrlHash hash ->
            receiveUrlHash hash model

        _ ->
            ( model, none )



-- VIEW


view : Signal.Address Action -> Model -> Html
view address model =
    div
        [ class "page" ]
        [ div
            [ class ("scene page" ++ (toString (indexLens.get model))) ]
            [ PechaKucha.Pages.view address model.pages ]
        , overlay address model
        , footer address model
        ]


clockLineStyle =
    { defaultLine | color = Color.gray, width = 10 }


opacityStep =
    0.3 / (5 * fps)


overlay : Signal.Address Action -> Model -> Html
overlay address model =
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


footer address model =
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
