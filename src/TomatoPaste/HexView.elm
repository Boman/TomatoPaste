module TomatoPaste.HexView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import TomatoPaste.Level exposing (..)
import TomatoPaste.Messages exposing (..)


getColorString : Color -> String
getColorString color =
    case color of
        Gray ->
            "gray"

        Green ->
            "green"

        Blue ->
            "blue"

        Red ->
            "red"

        Yellow ->
            "yellow"

        Pink ->
            "pink"

        Purple ->
            "purple"

        Cyan ->
            "cyan"

        Color1 ->
            "pink"


isObjectMoving : Object -> Bool
isObjectMoving object =
    case object of
        Unit _ moving ->
            moving

        _ ->
            False


getObjectImg : Hex -> String
getObjectImg hex =
    case hex.object of
        NoObject ->
            ""

        Pine ->
            "antiyoy/skins/jannes/field_elements/pine.png"

        Palm ->
            "antiyoy/skins/jannes/field_elements/palm.png"

        Town ->
            "antiyoy/skins/jannes/field_elements/castle.png"

        Tower ->
            "antiyoy/skins/jannes/field_elements/tower.png"

        Grave ->
            "antiyoy/skins/jannes/field_elements/grave.png"

        Farm ->
            "antiyoy/skins/jannes/field_elements/farm"
                ++ String.fromInt (modBy 3 (hex.position.x * 179 + hex.position.y * 367) + 1)
                ++ ".png"

        StrongTower ->
            "antiyoy/skins/jannes/field_elements/strong_tower.png"

        Unit strength _ ->
            "antiyoy/skins/jannes/field_elements/man"
                ++ String.fromInt (clamp 0 3 strength)
                ++ ".png"


viewHex : Hex -> Html Msg
viewHex hex =
    let
        r =
            28

        cx =
            toFloat hex.position.x * 1.5 * r * 0.7

        cy =
            r / 3 ^ 0.5 * toFloat (2 * hex.position.y + modBy 2 hex.position.x)
    in
    button
        [ style "position" "absolute"
        , style "top" (String.fromFloat cy ++ "px")
        , style "left" (String.fromFloat cx ++ "px")
        , style "background-color" (getColorString hex.color)
        , onClick (HexClicked hex.position.x hex.position.y)
        , style "height" (String.fromFloat r ++ "px")
        , style "width" (String.fromFloat r ++ "px")
        ]
        [ if hex.object == NoObject then
            text ""
            -- ++ (String.fromInt hex.position.x ++ ", " ++ String.fromInt hex.position.y)

          else
            img
                [ src (getObjectImg hex)
                , class
                    (if isObjectMoving hex.object then
                        "bounce"

                     else
                        "nobounce"
                    )
                , style "position" "relative"
                , style "top" "5px"
                , style "left" "-1px"
                , style "height" (String.fromFloat (r * 0.6) ++ "px")
                , style "width" (String.fromFloat (r * 0.6) ++ "px")
                ]
                []
        ]
