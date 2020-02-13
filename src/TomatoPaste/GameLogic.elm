module TomatoPaste.GameLogic exposing (..)

import TomatoPaste.Level exposing (..)
import TomatoPaste.Model exposing (..)


getHex : Model -> Position -> Object
getHex model position =
    Maybe.withDefault NoObject <|
        List.head <|
            List.filterMap
                (\hex ->
                    if position == hex.position then
                        Just hex.object

                    else
                        Nothing
                )
                model.level.hexes


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


hexClicked : Model -> Position -> Model
hexClicked model position =
    case model.focus of
        UnitFocus strength ->
            if getHex model position == NoObject then
                { model | level = Level <| updateElement model.level.hexes (Hex position Gray (Unit strength False)) }

            else
                model

        _ ->
            model
