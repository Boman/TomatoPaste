module TomatoPaste.Map exposing (..)

import Dict exposing (Dict)


type CellColor
    = Gray
    | Red
    | Cyan
    | Yellow
    | Color1
    | Green
    | Blue
    | Pink
    | Purple


type CellObject
    = NoObject
    | Pine
    | Palm
    | Town
    | Tower
    | Grave
    | Farm
    | StrongTower
    | Unit Int Bool


type alias MapPosition =
    ( Int, Int )


type alias Cells =
    Dict MapPosition Cell


type alias Cell =
    { object : CellObject
    , color : CellColor
    , province : Int
    }


type alias Province =
    { cells : List MapPosition
    , numFarms : Int
    }


type alias Map =
    { size : ( Int, Int )
    , cells : Cells
    , provinces : Dict Int Province
    }


type alias Hex =
    { position : MapPosition
    , color : CellColor
    , cellObject : CellObject
    }


type alias Level =
    { hexes : List Hex
    , playerColor : CellColor
    }


mapFromLevel : Level -> Map
mapFromLevel level =
    let
        positions =
            Dict.keys cells

        size =
            ( Maybe.withDefault 0 <| List.maximum (List.map (\( x, y ) -> x) positions)
            , Maybe.withDefault 0 <| List.maximum (List.map (\( x, y ) -> y) positions)
            )

        hexToCell : Hex -> ( MapPosition, Cell )
        hexToCell hex =
            ( hex.position, Cell hex.cellObject hex.color 0 )

        cells =
            Dict.fromList <| List.map hexToCell level.hexes

        provinces =
            Dict.empty
    in
    Map size cells provinces
