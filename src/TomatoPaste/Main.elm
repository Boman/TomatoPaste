module TomatoPaste.Main exposing (..)

import Browser
import Debug exposing (log)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import TomatoPaste.Antiyoy.AntiyoyLevels exposing (..)
import TomatoPaste.GameLogic exposing (..)
import TomatoPaste.HexView exposing (..)
import TomatoPaste.Level exposing (..)
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
        (parseLevelString getLevelString)
        NoFocus
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
            ( { model | level = parseLevelString model.levelContent }
            , Cmd.none
              --Http.get { url = model.levelContent, expect = Http.expectString ViewLevel }
            )

        ViewLevel result ->
            case result of
                Ok levelFile ->
                    ( { model | level = parseLevelString (log "levelString" (parseLevelFile (log "levelFile" levelFile))) }
                    , Cmd.none
                    )

                Err _ ->
                    ( model
                    , Cmd.none
                    )

        HexClicked x y ->
            ( hexClicked model (Position x y), Cmd.none )

        FarmClicked ->
            ( { model
                | focus =
                    FarmFocus
                        (case model.focus of
                            FarmFocus int ->
                                modBy 3 (int + 1)

                            _ ->
                                0
                        )
              }
            , Cmd.none
            )

        UnitClicked ->
            ( { model
                | focus =
                    UnitFocus
                        (case model.focus of
                            UnitFocus int ->
                                modBy 4 (int + 1)

                            _ ->
                                0
                        )
              }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ input
                [ placeholder model.levelContent
                , value model.levelContent
                , onInput LvlNameChanged
                ]
                []
            , button [ onClick LoadLevel ] [ text "load Level" ]
            , div [] [ viewOverlay model ]
            ]
        , div [ style "position" "absolute" ]
            [ node "link" [ rel "stylesheet", href "HexView.css" ] []
            , div [] (List.map viewHex model.level.hexes)
            ]
        ]
