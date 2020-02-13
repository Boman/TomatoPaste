module TomatoPaste.Messages exposing (..)

import Http


type Msg
    = LoadLevel
    | LvlNameChanged String
    | ViewLevel (Result Http.Error String)
    | HexClicked Int Int
    | FarmClicked
    | UnitClicked
