module TomatoPaste.Messages exposing (..)

import Http


type Msg
    = LoadLevel
    | LvlNameChanged String
    | ViewLevel (Result Http.Error String)
    | CellClicked Int Int
    | BuildingClicked
    | UnitClicked
    | UndoClicked
    | EndRoundClicked
