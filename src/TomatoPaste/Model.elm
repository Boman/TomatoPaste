module TomatoPaste.Model exposing (..)

import TomatoPaste.Map exposing (Map, MapPosition)


type alias Model =
    { levelContent : String
    , map : Map
    , gameState : GameState
    }


type GameState
    = NothingSelected
    | HexSelected MapPosition -- selectedPosition
    | HexAndBuildingSelected MapPosition Int (List MapPosition) -- selectedPosition buildingType possibleBuildingCells
    | HexAndUnitSelected MapPosition Int (List MapPosition) -- selectedPosition strength possibleUnitCells
    | HexWithBuildingSelected MapPosition (List MapPosition) -- selectedPosition protectedCells
    | HexWithUnitSelected MapPosition (List MapPosition) -- selectedPosition possibleCellsToMove
