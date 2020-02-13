module TomatoPaste.Model exposing (..)

import TomatoPaste.Level exposing (..)


type FocusElement
    = PositionFocus Position
    | FarmFocus Int
    | UnitFocus Int
    | NoFocus


type alias Model =
    { levelContent : String
    , level : Level
    , focus : FocusElement
    }
