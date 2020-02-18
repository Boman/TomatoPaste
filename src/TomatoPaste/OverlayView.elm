module TomatoPaste.OverlayView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import TomatoPaste.Messages exposing (..)
import TomatoPaste.Model exposing (..)


getBuildingImage buildingType =
    case buildingType of
        1 ->
            "tower"

        2 ->
            "strong_tower"

        _ ->
            "house"


viewOverlay : Model -> Html Msg
viewOverlay model =
    div []
        [ div
            [ style "position" "fixed"
            , style "left" "50%"
            , style "bottom" "25px"
            , style "transform" "translate(-50%, -50%)"
            , style "margin" "0 auto"
            ]
            [ case model.gameState of
                HexAndBuildingSelected _ buildingType _ ->
                    img
                        [ src <| "antiyoy/skins/jannes/field_elements/" ++ getBuildingImage buildingType ++ ".png"
                        , style "height" "50px"
                        , style "width" "50px"
                        ]
                        []

                HexAndUnitSelected _ strength _ ->
                    img
                        [ src <| "antiyoy/skins/jannes/field_elements/man" ++ String.fromInt strength ++ ".png"
                        , style "height" "50px"
                        , style "width" "50px"
                        ]
                        []

                _ ->
                    text ""
            ]
        , div
            [ style "position" "fixed"
            , style "left" "50%"
            , style "bottom" "25px"
            , style "transform" "translate(-50%, -50%)"
            , style "margin" "0 auto"
            ]
            [ case model.gameState of
                HexAndBuildingSelected _ buildingType _ ->
                    text <|
                        "$"
                            ++ (case buildingType of
                                    1 ->
                                        "15"

                                    2 ->
                                        "35"

                                    _ ->
                                        "12"
                               )

                HexAndUnitSelected _ strength _ ->
                    text <| "$" ++ (String.fromInt <| strength * 10 + 10)

                _ ->
                    text ""
            ]
        , if model.gameState == NothingSelected then
            text ""

          else
            div
                [ style "position" "fixed"
                , style "left" "50%"
                , style "bottom" "0"
                , style "transform" "translate(-50%, 0%)"
                , style "margin" "0 auto"
                ]
                [ input
                    [ onClick BuildingClicked
                    , type_ "image"
                    , src "antiyoy/skins/jannes/field_elements/house.png"
                    , style "height" "35px"
                    , style "width" "35px"
                    , style "margin" "0 40px 0 0"
                    ]
                    []
                , input
                    [ onClick UnitClicked
                    , type_ "image"
                    , src "antiyoy/skins/jannes/field_elements/man0.png"
                    , style "height" "35px"
                    , style "width" "35px"
                    ]
                    []
                ]
        , div
            [ style "position" "fixed"
            , style "left" "0%"
            , style "bottom" "0"
            , style "margin" "0 auto"
            ]
            [ input
                [ onClick UndoClicked
                , type_ "image"
                , src "antiyoy/undo.png"
                , style "height" "35px"
                , style "width" "35px"
                ]
                []
            ]
        , div
            [ style "position" "fixed"
            , style "right" "0%"
            , style "bottom" "0"
            , style "margin" "0 auto"
            ]
            [ input
                [ onClick EndRoundClicked
                , type_ "image"
                , src "antiyoy/end_turn.png"
                , style "height" "35px"
                , style "width" "35px"
                ]
                []
            ]
        ]
