module TomatoPaste.OverlayView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import TomatoPaste.Level exposing (..)
import TomatoPaste.Messages exposing (..)
import TomatoPaste.Model exposing (..)


getFarmFocusElement value =
    case value of
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
            [ case model.focus of
                FarmFocus int ->
                    img
                        [ src <| "antiyoy/skins/jannes/field_elements/" ++ getFarmFocusElement int ++ ".png"
                        , style "height" "50px"
                        , style "width" "50px"
                        ]
                        []

                UnitFocus int ->
                    img
                        [ src <| "antiyoy/skins/jannes/field_elements/man" ++ String.fromInt int ++ ".png"
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
            , style "bottom" "0"
            , style "transform" "translate(-50%, -50%)"
            , style "margin" "0 auto"
            ]
            [ input
                [ onClick FarmClicked
                , type_ "image"
                , src "antiyoy/skins/jannes/field_elements/house.png"
                , style "height" "35px"
                , style "width" "35px"
                , style "margin" "0 20px 0 0"
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
        ]
