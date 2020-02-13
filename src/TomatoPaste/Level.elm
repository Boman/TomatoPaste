module TomatoPaste.Level exposing (..)


type alias Hex =
    { position : Position
    , color : Color
    , object : Object
    }


type alias Level =
    { hexes : List Hex }


type alias Position =
    { x : Int
    , y : Int
    }


type Color
    = Gray
    | Red
    | Cyan
    | Yellow
    | Color1
    | Green
    | Blue
    | Pink
    | Purple


type Building
    = FarmBuilding
    | TowerBuilding Int


type Object
    = NoObject
    | Pine
    | Palm
    | Town
    | Tower
    | Grave
    | Farm
    | StrongTower
    | Unit Int Bool
