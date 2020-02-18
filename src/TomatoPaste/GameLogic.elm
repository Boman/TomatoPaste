module TomatoPaste.GameLogic exposing (..)

import TomatoPaste.Map exposing (..)
import TomatoPaste.Model exposing (..)


--getHex : Model -> MapPosition -> CellObject
--getHex model position =
--    Maybe.withDefault NoObject <|
--        List.head <|
--            List.filterMap
--                (\hex ->
--                    if position == hex.position then
--                        Just hex.cellObject

--                    else
--                        Nothing
--                )
--                model.level.hexes


updateElement : List Hex -> Hex -> List Hex
updateElement list hex =
    let
        toggle hex2 =
            if hex2.position == hex.position then
                hex

            else
                hex2
    in
    List.map toggle list


type alias HexInfo =
    { isOwnHex : Bool
    , isNeutralHex : Bool
    , cellObject : Maybe CellObject
    }


getHexInfo : Level -> MapPosition -> HexInfo
getHexInfo level position =
    let
        hex =
            List.head <| List.filter (\hex1 -> hex1.position == position) level.hexes

        cellObject =
            case hex of
                Just hex1 ->
                    Just hex1.cellObject

                Nothing ->
                    Nothing

        isOwnHex =
            case hex of
                Just hex1 ->
                    hex1.color == level.playerColor

                Nothing ->
                    False
    in
    HexInfo isOwnHex False cellObject


cellClicked : Model -> MapPosition -> Model
cellClicked model position =
    --    let
    --        hexInfo =
    --            getHexInfo model.level position
    --    in
    --    case model.gameState of
    --        NothingSelected ->
    --            if hexInfo.isOwnHex then
    --                { model | gameState = HexSelected position }
    --
    --            else
    --                { model | gameState = NothingSelected }
    --
    --        HexSelected selectedPosition ->
    --            if hexInfo.isOwnHex then
    --                { model | gameState = HexSelected position }
    --
    --            else
    --                { model | gameState = NothingSelected }
    --
    --        HexAndBuildingSelected selectedPosition buildingType ->
    --            if hexInfo.isOwnHex then
    --                { model | gameState = HexSelected position }
    --                -- todo test and put building
    --
    --            else
    --                { model | gameState = HexSelected selectedPosition }
    --
    --        HexAndUnitSelected selectedPosition unitStrength ->
    --            model
    --
    --        HexWithBuildingSelected selectedPosition ->
    --            model
    --
    --        HexWithUnitSelected selectedPosition ->
    model
