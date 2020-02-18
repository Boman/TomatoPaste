module TomatoPaste.Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import TomatoPaste.Antiyoy.AntiyoyLevels exposing (..)
import TomatoPaste.GameLogic exposing (..)
import TomatoPaste.Map exposing (..)
import TomatoPaste.MapView exposing (..)
import TomatoPaste.Messages exposing (..)
import TomatoPaste.Model exposing (..)
import TomatoPaste.OverlayView exposing (..)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model
        getLevelString
        (mapFromLevel <| parseLevelString getLevelString)
        NothingSelected
    , Cmd.none
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LvlNameChanged lvlName ->
            ( { model | levelContent = lvlName }
            , Cmd.none
            )

        LoadLevel ->
            ( model, Cmd.none )

        ViewLevel _ ->
            ( model, Cmd.none )

        CellClicked x y ->
            ( cellClicked model ( x, y ), Cmd.none )

        BuildingClicked ->
            --            case model.gameState of
            --                HexAndBuildingSelected position buildingType ->
            --                    ( { model | gameState = HexAndBuildingSelected position (modBy 3 (buildingType + 1)) }, Cmd.none )
            --
            --                HexSelected position ->
            --                    ( { model | gameState = HexAndBuildingSelected position 0 }, Cmd.none )
            --
            --                HexAndUnitSelected position _ ->
            --                    ( { model | gameState = HexAndBuildingSelected position 0 }, Cmd.none )
            --
            --                _ ->
            ( model, Cmd.none )

        UnitClicked ->
            --            case model.gameState of
            --                HexAndUnitSelected position strength ->
            --                    ( { model | gameState = HexAndUnitSelected position (modBy 4 (strength + 1)) }, Cmd.none )
            --
            --                HexSelected position ->
            --                    ( { model | gameState = HexAndUnitSelected position 0 }, Cmd.none )
            --
            --                HexAndBuildingSelected position _ ->
            --                    ( { model | gameState = HexAndUnitSelected position 0 }, Cmd.none )
            --
            --                _ ->
            ( model, Cmd.none )

        UndoClicked ->
            ( model, Cmd.none )

        EndRoundClicked ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div [ style "font-family" "\"Arial Black\", Gadget, sans-serif" ]
        [ div []
            [-- input [ placeholder model.levelContent, value model.levelContent, onInput LvlNameChanged ] []
             --, button [ onClick LoadLevel ] [ text "load Level" ]
            ]
        , div [] [ viewOverlay model ]
        , div [ style "position" "absolute" ]
            [ node "link" [ rel "stylesheet", href "HexView.css" ] []
            , viewMap model
            ]
        ]
