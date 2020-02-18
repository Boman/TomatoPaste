module TomatoPaste.MapView exposing (..)

import Color exposing (..)
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import TomatoPaste.Map exposing (..)
import TomatoPaste.Messages exposing (..)
import TomatoPaste.Model exposing (Model)


getColor : CellColor -> Color
getColor playerColor =
    case playerColor of
        Gray ->
            gray

        Green ->
            green

        Blue ->
            blue

        Red ->
            red

        Yellow ->
            yellow

        Pink ->
            red

        Purple ->
            purple

        Cyan ->
            red

        Color1 ->
            red


isObjectMoving : CellObject -> Bool
isObjectMoving object =
    case object of
        Unit _ moving ->
            moving

        _ ->
            False


getObjectImg : MapPosition -> Cell -> String
getObjectImg mapPosition cell =
    case cell.object of
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
                ++ String.fromInt (modBy 3 (Tuple.first mapPosition * 179 + Tuple.second mapPosition * 367) + 1)
                ++ ".png"

        StrongTower ->
            "antiyoy/skins/jannes/field_elements/strong_tower.png"

        Unit strength _ ->
            "antiyoy/skins/jannes/field_elements/man"
                ++ String.fromInt (clamp 0 3 strength)
                ++ ".png"


viewMap : Model -> Html Msg
viewMap model =
    div [] [ viewCells model.map.cells ]


viewCells : Cells -> Html Msg
viewCells cells =
    div [] <| List.map viewCell <| Dict.toList cells


viewCell : ( MapPosition, Cell ) -> Html Msg
viewCell ( mapPosition, cell ) =
    let
        r =
            28

        cx =
            toFloat (Tuple.first mapPosition) * 1.5 * r * 0.7

        cy =
            r / 3 ^ 0.5 * toFloat (2 * Tuple.second mapPosition + modBy 2 (Tuple.first mapPosition))
    in
    button
        [ style "position" "absolute"
        , style "top" (String.fromFloat cy ++ "px")
        , style "left" (String.fromFloat cx ++ "px")
        , style "background-color" (toCssString <| getColor cell.color)
        , onClick (CellClicked (Tuple.first mapPosition) (Tuple.second mapPosition))
        , style "height" (String.fromFloat r ++ "px")
        , style "width" (String.fromFloat r ++ "px")
        ]
        [ if cell.object == NoObject then
            text ""

          else
            img
                [ src (getObjectImg mapPosition cell)
                , class
                    (if isObjectMoving cell.object then
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
