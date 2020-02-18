module TomatoPaste.Antiyoy.AntiyoyLevels exposing (..)

import Debug exposing (..)
import List
import Parser exposing ((|.), (|=), DeadEnd, Parser, Trailing(..), chompUntil, chompUntilEndOr, chompWhile, getChompedString, int, run, sequence, spaces, succeed, symbol)
import TomatoPaste.Map exposing (..)


getLevelString =
    --"https://raw.githubusercontent.com/yiotro/Antiyoy/master/core/src/yio/tro/antiyoy/gameplay/user_levels/pack/Ulev1939Diacharik.java"
    --"3 4 6 7/28 1 0 0 0 0 10#27 1 0 0 0 0 10#26 1 0 0 0 0 10#28 2 0 0 0 0 10#28 3 0 0 0 0 10#25 2 0 0 0 0 10#24 3 0 0 0 0 10#24 4 0 0 0 0 10#24 5 0 0 0 0 10#25 5 0 0 0 0 10#26 5 0 0 0 0 10#27 4 0 0 0 0 10#27 3 0 4 0 0 10#26 3 0 3 0 0 10#25 4 0 0 0 0 10#26 4 0 0 0 0 10#26 2 0 0 0 0 10#25 3 0 4 0 0 10#27 2 0 0 0 0 10#23 4 7 1 0 0 10#23 5 7 1 0 0 10#23 6 7 1 0 0 10#22 4 7 1 0 0 10#21 4 7 1 0 0 10#20 5 7 1 0 0 10#19 6 7 1 0 0 10#19 7 7 1 0 0 10#19 8 7 1 0 0 10#20 8 7 1 0 0 10#21 8 7 1 0 0 10#22 7 7 1 0 0 10#22 6 7 2 0 0 10#22 5 7 2 0 0 10#20 6 7 2 0 0 10#21 7 7 2 0 0 10#21 5 7 2 0 0 10#21 6 7 2 0 0 10#20 7 7 2 0 0 10#18 7 3 0 0 0 10#18 8 3 3 0 0 10#18 9 3 0 0 0 10#17 8 3 0 0 0 10#17 7 3 0 0 0 10#16 7 3 0 0 0 10#15 8 3 0 0 0 10#14 9 3 0 0 0 10#14 10 3 0 0 0 10#14 11 3 0 0 0 10#15 11 3 0 0 0 10#16 11 3 0 0 0 10#17 10 3 0 0 0 10#17 9 3 4 0 0 10#16 9 3 0 0 0 10#15 10 3 0 0 0 10#16 8 3 0 0 0 10#16 10 3 0 0 0 10#15 9 3 4 0 0 10#24 7 4 0 0 0 10#24 6 4 0 0 0 10#25 6 4 0 0 0 10#26 6 4 0 0 0 10#23 7 4 3 0 0 10#22 8 4 0 0 0 10#22 9 4 0 0 0 10#22 10 4 0 0 0 10#23 10 4 0 0 0 10#24 10 4 0 0 0 10#25 9 4 0 0 0 10#26 8 4 0 0 0 10#26 7 4 0 0 0 10#25 8 4 4 0 0 10#24 9 4 0 0 0 10#25 7 4 0 0 0 10#24 8 4 0 0 0 10#23 9 4 0 0 0 10#23 8 4 4 0 0 10#21 9 2 0 0 0 10#20 9 2 0 0 0 10#19 9 2 0 0 0 10#18 10 2 0 0 0 10#17 11 2 3 0 0 10#21 10 2 0 0 0 10#21 11 2 0 0 0 10#20 12 2 0 0 0 10#19 13 2 0 0 0 10#18 12 2 0 0 0 10#17 12 2 0 0 0 10#17 13 2 0 0 0 10#18 13 2 0 0 0 10#19 12 2 0 0 0 10#18 11 2 4 0 0 10#20 10 2 0 0 0 10#20 11 2 4 0 0 10#19 11 2 0 0 0 10#19 10 2 0 0 0 10#14 12 6 0 0 0 10#15 12 6 0 0 0 10#16 12 6 0 0 0 10#16 13 6 0 0 0 10#16 14 6 0 0 0 10#13 13 6 0 0 0 10#12 14 6 0 0 0 10#12 15 6 3 0 0 10#12 16 6 0 0 0 10#13 16 6 0 0 0 10#15 15 6 0 0 0 10#14 16 6 0 0 0 10#13 15 6 0 0 0 10#13 14 6 4 0 0 10#15 13 6 0 0 0 10#14 15 6 0 0 0 10#14 14 6 0 0 0 10#15 14 6 4 0 0 10#14 13 6 0 0 0 10#27 5 5 0 0 0 10#27 6 5 0 0 0 10#27 7 5 0 0 0 10#28 4 5 0 0 0 10#29 3 5 0 0 0 10#30 3 5 0 0 0 10#31 3 5 0 0 0 10#31 4 5 0 0 0 10#31 5 5 0 0 0 10#30 6 5 0 0 0 10#29 7 5 0 0 0 10#28 7 5 0 0 0 10#28 5 5 4 0 0 10#28 6 5 0 0 0 10#29 5 5 0 0 0 10#30 4 5 0 0 0 10#30 5 5 3 0 0 10#29 6 5 0 0 0 10#29 4 5 0 0 0 10#31 6 7 2 0 0 10#30 7 7 2 0 0 10#29 8 3 0 0 0 10#31 7 7 1 0 0 10#27 8 3 0 0 0 10#28 8 3 0 0 0 10#29 9 3 0 0 0 10#29 10 3 0 0 0 10#26 9 3 0 0 0 10#25 10 3 0 0 0 10#25 11 3 0 0 0 10#25 12 3 0 0 0 10#26 12 3 0 0 0 10#27 12 3 0 0 0 10#28 11 3 0 0 0 10#28 9 3 0 0 0 10#27 10 3 0 0 0 10#28 10 3 4 0 0 10#27 11 3 0 0 0 10#26 11 3 0 0 0 10#27 9 3 0 0 0 10#26 10 3 3 0 0 10#30 8 7 2 0 0 10#30 9 7 2 0 0 10#32 5 7 2 0 0 10#33 5 7 2 0 0 10#34 5 7 2 0 0 10#34 6 7 2 0 0 10#34 7 7 2 0 0 10#31 9 7 2 0 0 10#32 9 7 2 0 0 10#33 8 7 2 0 0 10#32 7 7 1 0 0 10#33 7 7 1 0 0 10#32 8 7 1 0 0 10#31 8 7 1 0 0 10#32 6 7 1 0 0 10#33 6 7 1 0 0 10#17 14 5 0 0 0 10#18 14 5 0 0 0 10#19 14 5 0 0 0 10#16 15 5 0 0 0 10#15 16 5 0 0 0 10#19 15 5 0 0 0 10#19 16 5 0 0 0 10#18 16 5 4 0 0 10#18 17 5 0 0 0 10#16 18 5 0 0 0 10#17 18 5 0 0 0 10#15 18 5 0 0 0 10#15 17 5 0 0 0 10#17 16 5 0 0 0 10#17 15 5 0 0 0 10#18 15 5 0 0 0 10#16 16 5 3 0 0 10#17 17 5 0 0 0 10#16 17 5 0 0 0 10#22 11 7 2 0 0 10#21 12 7 2 0 0 10#20 13 7 2 0 0 10#20 14 7 2 0 0 10#20 15 7 2 0 0 10#23 11 7 2 0 0 10#24 11 7 2 0 0 10#24 12 7 2 0 0 10#24 13 7 2 0 0 10#21 15 7 2 0 0 10#22 15 7 2 0 0 10#23 14 7 2 0 0 10#22 13 7 1 0 0 10#22 12 7 1 0 0 10#23 12 7 1 0 0 10#22 14 7 1 0 0 10#23 13 7 1 0 0 10#21 13 7 1 0 0 10#21 14 7 1 0 0 10#12 17 7 2 0 0 10#13 17 7 2 0 0 10#14 17 7 2 0 0 10#14 18 7 2 0 0 10#14 19 7 2 0 0 10#11 18 7 2 0 0 10#10 19 7 2 0 0 10#13 20 7 2 0 0 10#12 21 7 2 0 0 10#11 21 7 2 0 0 10#10 21 7 2 0 0 10#10 20 7 2 0 0 10#11 19 7 1 0 0 10#13 18 7 1 0 0 10#12 20 7 1 0 0 10#11 20 7 1 0 0 10#13 19 7 1 0 0 10#12 19 7 1 0 0 10#12 18 7 1 0 0 10#30 11 1 0 0 0 10#30 10 1 0 0 0 10#31 10 1 0 0 0 10#32 10 1 0 0 0 10#29 11 1 0 0 0 10#28 12 1 0 0 0 10#31 11 1 0 0 0 10#32 11 1 0 0 0 10#32 12 1 0 0 0 10#28 13 1 0 0 0 10#28 14 1 0 0 0 10#29 14 1 0 0 0 10#30 14 1 0 0 0 10#31 13 1 0 0 0 10#30 12 1 3 0 0 10#31 12 1 4 0 0 10#30 13 1 0 0 0 10#29 12 1 4 0 0 10#29 13 1 0 0 0 10#15 19 4 0 0 0 10#17 19 4 0 0 0 10#16 19 4 0 0 0 10#14 20 4 0 0 0 10#13 21 4 0 0 0 10#14 22 4 0 0 0 10#13 22 4 3 0 0 10#13 23 4 0 0 0 10#14 23 4 0 0 0 10#15 23 4 0 0 0 10#16 21 4 4 0 0 10#15 22 4 0 0 0 10#16 22 4 0 0 0 10#17 20 4 0 0 0 10#17 21 4 0 0 0 10#15 20 4 0 0 0 10#15 21 4 0 0 0 10#16 20 4 0 0 0 10#14 21 4 4 0 0 10#20 16 0 0 0 0 10#21 16 0 0 0 0 10#22 16 0 0 0 0 10#19 17 0 0 0 0 10#18 18 0 3 0 0 10#18 19 0 0 0 0 10#19 19 0 0 0 0 10#18 20 0 0 0 0 10#19 20 0 0 0 0 10#20 20 0 0 0 0 10#22 17 0 0 0 0 10#21 19 0 0 0 0 10#22 18 0 0 0 0 10#21 18 0 4 0 0 10#20 17 0 0 0 0 10#21 17 0 0 0 0 10#20 19 0 0 0 0 10#20 18 0 0 0 0 10#19 18 0 4 0 0 10#18 22 1 0 0 0 10#18 21 1 0 0 0 10#17 22 1 0 0 0 10#16 23 1 0 0 0 10#19 21 1 0 0 0 10#20 21 1 0 0 0 10#16 24 1 0 0 0 10#16 25 1 0 0 0 10#17 25 1 0 0 0 10#18 25 1 0 0 0 10#19 24 1 0 0 0 10#20 23 1 0 0 0 10#20 22 1 0 0 0 10#19 22 1 0 0 0 10#18 23 1 0 0 0 10#19 23 1 4 0 0 10#18 24 1 0 0 0 10#17 24 1 0 0 0 10#17 23 1 3 0 0 10#21 20 2 0 0 0 10#21 21 2 0 0 0 10#21 22 2 0 0 0 10#23 18 2 0 0 0 10#22 19 2 0 0 0 10#23 19 2 0 0 0 10#24 18 2 0 0 0 10#25 18 2 0 0 0 10#25 19 2 0 0 0 10#25 20 2 0 0 0 10#22 22 2 0 0 0 10#23 22 2 0 0 0 10#24 21 2 0 0 0 10#24 20 2 4 0 0 10#24 19 2 0 0 0 10#23 21 2 0 0 0 10#22 20 2 4 0 0 10#23 20 2 3 0 0 10#22 21 2 0 0 0 10#23 15 6 0 0 0 10#24 14 6 0 0 0 10#25 14 6 0 0 0 10#25 13 6 0 0 0 10#26 13 6 0 0 0 10#27 13 6 0 0 0 10#27 14 6 0 0 0 10#27 15 6 0 0 0 10#23 16 6 0 0 0 10#24 17 6 0 0 0 10#23 17 6 0 0 0 10#25 17 6 0 0 0 10#26 16 6 0 0 0 10#26 15 6 4 0 0 10#26 14 6 0 0 0 10#25 16 6 3 0 0 10#24 15 6 4 0 0 10#25 15 6 0 0 0 10#24 16 6 0 0 0 10#28 15 7 1 0 0 10#29 15 7 1 0 0 10#30 15 7 1 0 0 10#27 16 7 1 0 0 10#26 17 7 1 0 0 10#26 18 7 1 0 0 10#26 19 7 1 0 0 10#30 16 7 1 0 0 10#30 17 7 1 0 0 10#29 18 7 1 0 0 10#28 19 7 1 0 0 10#27 19 7 1 0 0 10#27 17 7 2 0 0 10#28 17 7 2 0 0 10#29 16 7 2 0 0 10#29 17 7 2 0 0 10#28 18 7 2 0 0 10#27 18 7 2 0 0 10#28 16 7 2 0 0 10"
    --"4 4 1 7/31 17 0 0 0 0 10#13 12 0 0 0 0 10#13 13 0 0 0 0 10#13 21 1 0 0 0 10#20 14 0 0 0 0 10#17 11 0 0 0 0 10#17 12 0 0 0 0 10#18 12 0 0 0 0 10#17 13 0 0 0 0 10#18 13 0 0 0 0 10#19 13 0 6 0 0 10#19 12 0 3 0 0 10#20 12 0 6 0 0 10#14 20 1 6 0 0 10#12 20 1 0 0 0 10#12 25 7 0 0 0 10#11 24 7 6 0 0 10#12 24 7 0 0 0 10#13 24 7 0 0 0 10#11 22 7 0 0 0 10#10 24 7 0 0 0 10#11 23 7 0 0 0 10#12 23 7 0 0 0 10#14 22 7 0 0 0 10#13 23 7 3 0 0 10#11 21 1 7 0 0 10#13 19 1 0 0 0 10#13 20 1 3 0 0 10#14 19 1 6 0 0 10#15 21 0 3 0 0 10#15 20 0 0 0 0 10#15 18 1 0 0 0 10#15 19 3 0 0 0 10#18 20 3 0 0 0 10#19 20 1 1 0 0 10#18 18 3 6 0 0 10#18 19 3 0 0 0 10#17 20 0 0 0 0 10#18 21 5 0 0 0 10#19 21 5 0 0 0 10#20 21 1 1 0 0 10#21 21 1 1 0 0 10#18 24 5 0 0 0 10#19 23 5 0 0 0 10#19 22 5 0 0 0 10#20 22 1 7 0 0 10#22 21 1 1 0 0 10#23 20 1 4 0 0 10#21 19 1 4 0 0 10#23 19 1 4 0 0 10#22 19 1 4 0 0 10#22 20 1 1 0 0 10#21 20 1 1 0 0 10#20 20 1 1 0 0 10#20 19 1 4 0 0 10#19 19 3 4 0 0 10#19 18 4 3 0 0 10#19 17 4 6 0 0 10#20 16 4 0 0 0 10#19 16 3 0 0 0 10#18 17 3 3 0 0 10#16 18 3 3 0 0 10#17 18 3 6 0 0 10#16 19 3 0 0 0 10#17 19 3 3 0 0 10#16 20 0 6 0 0 10#18 22 5 0 0 0 10#18 23 5 0 0 0 10#17 24 5 0 0 0 10#16 25 5 0 0 0 10#17 25 5 0 0 0 10#21 22 5 0 0 0 10#20 23 5 0 0 0 10#19 24 5 0 0 0 10#19 25 5 0 0 0 10#22 22 5 0 0 0 10#23 21 1 1 0 0 10#24 20 1 4 0 0 10#20 13 0 0 0 0 10#23 12 7 7 0 0 10#23 11 2 7 0 0 10#22 14 6 6 0 0 10#22 13 7 6 0 0 10#22 12 0 0 0 0 10#22 10 2 6 0 0 10#22 11 2 0 2 0 10#21 11 0 0 0 0 10#21 12 0 0 0 0 10#21 13 0 0 0 0 10#21 14 0 7 0 0 10#24 16 6 6 0 0 10#25 16 1 3 0 0 10#23 16 6 6 0 0 10#22 16 1 4 0 0 10#21 17 4 4 0 0 10#22 17 1 6 0 0 10#23 17 1 6 0 0 10#21 15 0 0 0 0 10#22 15 6 6 0 0 10#21 16 4 4 0 0 10#20 17 4 0 0 0 10#20 18 4 6 0 0 10#21 18 1 4 0 0 10#22 18 1 6 0 0 10#23 18 1 6 0 0 10#24 17 1 6 0 0 10#24 19 1 3 0 0 10#26 18 5 0 0 0 10#26 19 5 0 0 0 10#24 18 1 4 0 0 10#25 17 6 6 0 0 10#25 18 6 3 0 0 10#25 19 5 0 0 0 10#25 22 5 6 0 0 10#28 22 5 0 0 0 10#27 22 5 0 0 0 10#26 22 5 0 0 0 10#25 21 5 0 0 0 10#24 22 5 6 0 0 10#23 23 5 6 0 0 10#24 23 5 6 0 0 10#25 23 5 3 0 0 10#26 23 5 6 0 0 10#27 23 5 0 0 0 10#29 21 5 0 0 0 10#28 21 5 0 1 0 10#27 21 5 0 1 0 10#26 21 5 0 0 0 10#26 20 5 0 0 0 10#25 20 5 0 0 0 10#24 21 5 7 0 0 10#23 22 5 6 0 0 10#22 23 5 6 0 0 10#21 23 5 0 0 0 10#25 24 5 0 0 0 10#24 24 5 0 0 0 10#23 24 5 6 0 0 10#22 24 5 6 0 0 10#21 24 5 6 0 0 10#20 24 5 0 0 0 10#20 25 5 0 0 0 10#22 25 5 0 0 0 10#22 9 6 0 0 0 10#22 8 6 3 0 0 10#22 7 6 0 0 0 10#22 6 6 2 0 0 10#21 6 6 0 0 0 10#21 5 6 2 0 0 10#22 4 6 3 0 0 10#23 3 6 6 0 0 10#24 2 7 7 0 0 10#24 3 7 7 0 0 10#25 3 7 7 0 0 10#26 3 7 7 0 0 10#26 4 6 6 0 0 10#25 5 6 6 0 0 10#24 6 6 0 0 0 10#23 7 6 0 0 0 10#23 6 6 0 0 0 10#23 5 6 6 0 0 10#22 5 6 6 0 0 10#23 4 6 6 0 0 10#24 4 6 6 0 0 10#25 4 6 3 0 0 10#24 5 6 0 0 0 10#23 8 6 0 0 0 10#24 7 6 0 0 0 10#24 8 2 6 0 0 10#23 9 2 6 0 0 10#23 10 2 0 2 0 10#25 8 2 4 0 0 10#26 7 2 6 0 0 10#27 6 2 0 0 0 10#25 9 2 3 0 0 10#26 8 2 4 0 0 10#24 10 2 7 0 0 10#24 9 2 4 0 0 10#26 9 2 4 0 0 10#26 10 2 0 0 0 10#26 11 2 0 0 0 10#26 12 6 6 0 0 10#26 13 6 6 0 0 10#25 14 6 6 0 0 10#25 15 6 6 0 0 10#24 15 6 6 0 0 10#23 15 6 6 0 0 10#23 14 6 6 0 0 10#23 13 6 6 0 0 10#24 13 6 6 0 0 10#24 12 6 6 0 0 10#25 11 2 0 0 0 10#25 10 2 4 0 0 10#24 11 2 7 0 0 10#25 12 6 6 0 0 10#25 13 6 6 0 0 10#24 14 6 3 0 0 10#31 14 1 0 0 0 10#31 13 1 0 0 0 10#28 19 0 3 0 0 10#28 18 0 0 0 0 10#28 20 0 0 0 0 10#29 20 0 0 0 0 10#29 19 0 0 0 0 10#30 18 0 0 0 0 10#29 18 0 0 0 0 10#30 19 0 0 0 0 10#30 13 1 3 0 0 10#30 12 1 0 0 0 10#31 16 7 7 0 0 10#31 15 7 7 0 0 10#30 15 7 7 0 0 10#30 16 7 7 0 0 10#29 15 1 0 0 0 10#28 16 7 7 0 0 10#28 15 1 0 0 0 10#27 15 1 0 0 0 10#27 14 1 3 0 0 10#27 13 1 0 0 0 10#28 13 1 0 0 0 10#30 14 1 0 0 0 10#27 9 1 7 0 0 10#28 9 1 6 0 0 10#28 8 1 3 0 0 10#28 7 1 0 0 0 10#29 7 1 0 0 0 10#29 8 1 6 0 0 10#30 8 1 0 0 0 10#31 8 1 0 0 0 10#29 9 1 0 4 0 10#30 6 1 0 0 0 10#31 6 1 0 0 0 10#31 5 1 0 0 0 10#16 26 5 1 0 0 10#15 26 5 1 0 0 10#14 26 5 0 0 0 10#15 25 5 0 0 0 10#13 26 5 0 0 0 10#12 26 7 0 0 0 10#13 27 5 0 0 0 10#15 27 5 0 0 0 10#14 27 5 0 0 0 10#16 27 5 0 0 0 10#20 15 0 0 0 0 10#12 14 0 0 0 0 10#12 15 0 0 0 0 10#11 16 0 0 0 0 10#12 12 0 3 0 0 10#11 12 0 0 0 0 10#10 13 0 7 0 0 10#9 13 0 7 0 0 10#9 14 0 7 0 0 10#11 15 0 0 0 0 10#10 15 0 0 0 0 10#9 15 0 4 0 0 10#12 13 0 0 0 0 10#11 13 0 0 0 0 10#11 14 0 0 0 0 10#10 14 0 4 0 0 10#10 16 0 0 0 0 10#9 16 0 0 0 0 10#8 16 1 4 0 0 10#14 11 0 0 0 0 10#14 10 2 0 0 0 10#13 10 0 0 0 0 10#12 11 0 0 0 0 10#11 11 0 0 0 0 10#10 12 0 6 0 0 10#13 11 0 0 0 0 10#14 9 2 0 0 0 10#15 8 2 0 0 0 10#15 7 2 0 0 0 10#16 6 2 0 0 0 10#15 6 2 0 0 0 10#15 5 2 0 0 0 10#14 7 2 0 0 0 10#14 6 2 7 0 0 10#13 8 2 4 0 0 10#14 8 2 0 0 0 10#12 9 2 4 0 0 10#18 6 2 0 0 0 10#18 5 2 0 0 0 10#19 4 2 4 0 0 10#19 3 2 4 0 0 10#18 3 2 0 0 0 10#17 3 2 4 0 0 10#17 5 2 0 0 0 10#18 4 2 7 0 0 10#16 4 2 0 0 0 10#17 4 2 7 0 0 10#16 5 2 0 0 0 10#16 8 2 0 0 0 10#16 7 2 0 0 0 10#17 6 2 0 0 0 10#17 7 2 0 0 0 10#15 9 2 0 0 0 10#20 3 6 0 0 0 10#20 2 6 3 0 0 10#19 2 6 4 0 0 10#18 2 2 0 0 0 10#21 3 1 3 0 0 10#22 3 1 0 0 0 10#19 5 2 4 0 0 10#20 4 2 3 0 0 10#13 9 2 0 0 0 10#11 10 2 7 0 0 10#12 10 0 0 0 0 10#8 13 2 4 0 0 10#10 11 2 6 0 0 10#9 12 2 4 0 0 10#8 14 2 7 0 0 10#8 15 2 4 0 0 10#16 11 0 0 0 0 10#15 11 0 0 0 0 10#10 17 1 0 0 0 10#10 18 1 0 0 0 10#9 19 1 4 0 0 10#9 20 1 3 0 0 10#9 21 1 4 0 0 10#8 22 1 0 0 0 10#8 23 2 6 0 0 10#8 24 2 3 0 0 10#8 25 7 7 0 0 10#7 24 2 6 0 0 10#6 24 1 0 0 0 10#9 18 1 0 0 0 10#9 17 1 0 0 0 10#8 17 1 7 0 0 10#7 16 1 3 0 0 10#7 15 1 4 0 0 10#8 18 1 4 0 0 10#7 17 1 4 0 0 10#7 18 1 4 0 0 10#7 19 1 7 0 0 10#8 19 1 0 0 0 10#8 20 1 4 0 0 10#6 20 1 4 0 0 10#6 21 1 0 0 0 10#7 21 1 0 0 0 10#8 21 1 4 0 0 10#7 22 1 0 0 0 10#6 19 1 0 0 0 10#7 20 1 0 0 0 10#6 22 1 0 0 0 10#6 23 1 0 0 0 10#7 23 1 0 0 0 10#9 25 7 7 0 0 10#7 25 2 6 0 0 10#7 26 2 6 0 0 10#6 25 2 6 0 0 10#8 26 7 4 0 0 10#8 27 7 0 0 0 10#17 23 5 0 0 0 10#16 23 5 0 0 0 10#16 22 5 0 0 0 10#20 7 6 0 0 0 10#21 7 6 0 0 0 10#12 21 1 0 0 0 10"
    --"4 4 1 7/9 26 4 0 0 0 10#14 21 4 6 0 0 10#18 10 0 0 0 0 10#17 13 0 0 0 0 10#12 21 4 6 0 0 10#21 7 0 0 0 0 10#20 7 0 0 0 0 10#16 22 4 6 0 0 10#16 23 4 3 0 0 10#17 23 4 6 0 0 10#16 11 0 0 0 0 10#22 3 0 0 0 0 10#12 26 4 7 0 0 10#13 26 6 0 0 0 10#15 25 4 6 0 0 10#14 26 6 0 0 0 10#15 26 6 1 0 0 10#16 26 6 1 0 0 10#17 26 6 1 0 0 10#31 5 1 6 0 0 10#31 6 1 6 0 0 10#30 6 1 6 0 0 10#29 9 1 0 4 0 10#32 8 1 6 0 0 10#31 8 1 6 0 0 10#30 8 1 6 0 0 10#29 8 1 6 0 0 10#29 7 1 6 0 0 10#28 7 1 6 0 0 10#28 8 1 3 0 0 10#28 9 1 6 0 0 10#27 9 1 7 0 0 10#30 14 7 0 0 0 10#28 13 7 0 0 0 10#27 13 7 0 0 0 10#27 14 7 3 0 0 10#27 15 7 0 0 0 10#28 15 7 0 0 0 10#28 16 7 7 0 0 10#29 15 7 0 0 0 10#30 16 7 7 0 0 10#30 15 7 7 0 0 10#31 15 7 7 0 0 10#31 16 7 7 0 0 10#32 16 7 7 0 0 10#32 17 7 7 0 0 10#33 16 7 7 0 0 10#33 17 6 0 0 0 10#32 18 6 0 0 0 10#33 18 6 0 0 0 10#30 12 7 0 0 0 10#30 13 7 3 0 0 10#34 15 7 0 0 0 10#31 21 6 0 0 0 10#32 15 7 7 0 0 10#34 16 7 0 0 0 10#34 17 7 0 0 0 10#32 19 6 0 0 0 10#31 19 6 0 0 0 10#30 19 6 0 0 0 10#29 18 6 0 0 0 10#30 18 6 0 0 0 10#29 19 6 0 0 0 10#29 20 6 0 0 0 10#28 20 6 0 0 0 10#28 18 6 0 0 0 10#28 19 6 6 0 0 10#31 12 7 0 0 0 10#31 13 7 0 0 0 10#31 14 7 0 0 0 10#33 15 7 0 0 0 10#24 14 7 6 0 0 10#25 13 7 3 0 0 10#25 12 7 6 0 0 10#24 11 2 6 0 0 10#25 10 2 0 0 0 10#25 11 2 6 0 0 10#24 12 2 6 0 0 10#24 13 7 6 0 0 10#23 13 7 0 0 0 10#23 14 7 6 0 0 10#23 15 5 6 0 0 10#24 15 5 6 0 0 10#25 15 7 3 0 0 10#25 14 7 0 0 0 10#26 13 7 6 0 0 10#26 12 7 6 0 0 10#26 11 2 6 0 0 10#26 10 2 1 0 0 10#26 9 2 0 0 0 10#24 9 2 0 0 0 10#24 10 2 0 0 0 10#26 8 2 0 0 0 10#25 9 2 3 0 0 10#27 6 2 6 0 0 10#26 7 2 6 0 0 10#25 8 2 0 0 0 10#23 10 2 0 0 0 10#23 9 2 6 0 0 10#24 8 2 6 0 0 10#23 8 0 7 0 0 10#24 5 0 0 0 0 10#25 4 0 0 0 0 10#24 4 0 6 0 0 10#23 4 0 6 0 0 10#22 5 0 6 0 0 10#23 5 0 6 0 0 10#23 6 0 0 0 0 10#23 7 0 6 0 0 10#26 3 7 7 0 0 10#25 3 7 7 0 0 10#24 3 7 7 0 0 10#24 2 7 7 0 0 10#23 3 0 6 0 0 10#22 4 0 0 0 0 10#21 5 0 0 0 0 10#21 6 0 0 0 0 10#22 6 0 2 0 0 10#22 7 0 0 0 0 10#22 8 0 3 0 0 10#22 9 0 7 0 0 10#27 26 6 6 0 0 10#26 26 6 1 0 0 10#25 26 6 0 0 0 10#24 26 6 6 0 0 10#23 26 6 6 0 0 10#22 26 6 6 0 0 10#21 26 6 6 0 0 10#20 26 6 6 0 0 10#19 26 6 6 0 0 10#28 25 6 0 0 0 10#27 25 6 0 0 0 10#26 25 6 1 0 0 10#25 25 6 6 0 0 10#24 25 6 6 0 0 10#23 25 6 0 0 0 10#22 25 6 6 0 0 10#21 25 6 0 0 0 10#20 25 6 3 0 0 10#20 24 6 0 0 0 10#21 24 6 0 0 0 10#22 24 6 0 0 0 10#23 24 6 0 0 0 10#24 24 6 7 0 0 10#25 24 6 7 0 0 10#26 24 6 0 0 0 10#27 24 6 0 0 0 10#28 24 6 0 0 0 10#21 23 6 0 0 0 10#22 23 6 0 0 0 10#23 22 6 0 2 0 10#24 21 1 0 1 0 10#26 20 6 0 2 0 10#26 21 6 0 0 0 10#27 21 6 3 0 0 10#28 21 6 0 0 0 10#29 21 6 0 0 0 10#29 22 6 0 0 0 10#29 23 6 0 0 0 10#28 23 6 0 0 0 10#27 23 6 0 0 0 10#26 23 6 6 0 0 10#25 23 6 3 0 0 10#24 23 6 0 0 0 10#23 23 6 0 0 0 10#24 22 6 0 0 0 10#26 22 6 7 0 0 10#27 22 6 4 0 0 10#28 22 6 0 0 0 10#25 22 6 0 0 0 10#30 20 6 0 0 0 10#31 20 6 6 0 0 10#32 20 6 0 0 0 10#33 19 6 0 0 0 10#25 19 6 0 2 0 10#25 18 5 6 0 0 10#25 17 5 6 0 0 10#24 18 5 3 0 0 10#24 19 1 0 1 0 10#24 17 1 1 0 0 10#23 18 1 1 0 0 10#22 18 1 6 0 0 10#21 18 1 0 1 0 10#20 18 3 6 0 0 10#20 17 3 0 0 0 10#21 16 3 6 0 0 10#22 15 3 0 0 0 10#21 15 3 0 0 0 10#23 17 5 0 2 0 10#22 17 3 6 0 0 10#21 17 3 6 0 0 10#22 16 5 6 0 0 10#23 16 5 6 0 0 10#25 16 1 1 0 0 10#24 16 5 3 0 0 10#21 14 3 6 0 0 10#21 13 7 0 0 0 10#21 12 2 0 0 0 10#22 11 2 6 0 0 10#22 10 2 6 0 0 10#22 12 2 0 0 0 10#22 13 7 0 0 0 10#22 14 3 0 0 0 10#23 11 2 6 0 0 10#23 12 2 6 0 0 10#20 13 2 0 0 0 10#24 20 1 1 0 0 10#23 21 1 1 0 0 10#22 22 6 0 0 0 10#19 25 6 1 0 0 10#19 24 6 0 0 0 10#20 23 6 0 2 0 10#21 22 1 3 0 0 10#18 26 6 6 0 0 10#18 25 6 1 0 0 10#17 25 6 0 0 0 10#16 25 4 6 0 0 10#17 24 4 4 0 0 10#18 23 1 1 0 0 10#18 22 4 6 0 0 10#16 20 4 6 0 0 10#17 19 4 0 0 0 10#16 19 4 6 0 0 10#17 18 4 6 0 0 10#18 17 3 3 0 0 10#20 16 3 0 0 0 10#19 17 3 6 0 0 10#19 18 3 0 0 0 10#19 19 3 0 2 0 10#20 19 1 0 1 0 10#20 20 1 1 0 0 10#21 20 1 1 0 0 10#22 20 1 1 0 0 10#22 19 1 1 0 0 10#23 19 1 0 1 0 10#21 19 1 1 0 0 10#23 20 1 1 0 0 10#22 21 1 1 0 0 10#20 22 1 0 1 0 10#19 22 1 0 1 0 10#19 23 6 0 0 0 10#18 24 6 0 2 0 10#21 21 1 1 0 0 10#20 21 1 1 0 0 10#19 21 1 1 0 0 10#18 21 4 6 0 0 10#17 20 3 0 0 0 10#18 19 3 0 0 0 10#18 18 3 6 0 0 10#19 20 3 0 2 0 10#18 20 3 0 0 0 10#15 19 4 0 0 0 10#15 20 4 6 0 0 10#15 21 4 6 0 0 10#13 20 4 3 0 0 10#13 19 4 0 2 0 10#11 21 4 7 0 0 10#13 23 4 3 0 0 10#14 22 4 6 0 0 10#12 23 4 6 0 0 10#11 23 4 6 0 0 10#10 24 4 6 0 0 10#10 25 4 6 0 0 10#13 24 4 6 0 0 10#12 24 4 6 0 0 10#11 25 4 6 0 0 10#10 26 4 0 0 0 10#11 24 4 6 0 0 10#12 25 4 6 0 0 10#11 26 4 0 0 0 10#12 20 4 6 0 0 10#14 20 4 6 0 0 10#20 12 2 6 0 0 10#19 12 0 3 0 0 10#19 13 2 6 0 0 10#18 13 2 0 0 0 10#18 12 0 0 0 0 10#17 12 0 0 0 0 10#17 11 0 0 0 0 10#20 14 3 0 0 0 10#26 19 6 0 0 0 10#26 18 6 0 0 0 10#25 20 1 0 1 0 10#25 21 6 0 0 0 10#32 14 7 0 0 0 10#32 13 7 0 0 0 10#33 14 7 0 0 0 10#24 6 0 0 0 0 10"
    "3 4 1 7/25 24 0 3 0 0 10#26 23 0 4 0 0 10#26 22 0 0 1 1 10#27 22 7 0 0 0 10#28 22 7 0 0 0 10#29 22 7 0 0 0 10#30 21 7 0 0 0 10#30 20 7 0 0 0 10#30 19 7 2 0 0 10#31 17 7 2 0 0 10#35 3 0 0 1 1 10#35 2 0 3 0 0 10#36 2 7 0 0 0 10#37 1 7 0 0 0 10#38 1 7 0 0 0 10#38 2 7 0 0 0 10#38 3 7 0 0 0 10#38 4 7 0 0 0 10#38 5 7 0 0 0 10#31 15 7 0 0 0 10#33 10 7 0 0 0 10#32 11 7 0 0 0 10#27 10 1 6 0 0 10#27 11 1 6 0 0 10#28 11 1 0 0 0 10#28 10 1 6 0 0 10#28 12 1 6 0 0 10#28 13 1 4 0 0 10#27 12 1 6 0 0 10#26 12 1 6 0 0 10#25 13 1 0 0 0 10#26 13 1 6 0 0 10#25 14 7 0 0 0 10#26 14 1 6 0 0 10#27 13 1 6 0 0 10#26 11 1 3 0 0 10#26 10 1 0 0 0 10#25 10 1 0 0 0 10#25 11 1 0 0 0 10#25 12 1 0 0 0 10#27 14 1 6 0 0 10#24 14 1 0 0 0 10#23 14 1 0 0 0 10#23 15 1 0 0 0 10#24 16 1 0 0 0 10#25 16 1 6 0 0 10#26 16 1 6 0 0 10#27 15 1 6 0 0 10#28 14 1 0 0 0 10#25 15 1 6 0 0 10#26 15 1 4 0 0 10#23 16 1 0 0 0 10#24 15 1 4 0 0 10#24 13 1 4 0 0 10#23 13 1 4 0 0 10#37 6 7 0 0 0 10#36 7 7 0 0 0 10#36 6 7 2 0 0 10#35 6 7 2 0 0 10#35 5 7 0 0 0 10#34 5 7 0 0 0 10#33 5 7 0 0 0 10#33 4 7 0 0 0 10#32 4 7 0 0 0 10#31 4 7 2 0 0 10#30 4 7 0 0 0 10#29 4 7 0 0 0 10#30 3 7 0 0 0 10#29 3 7 0 0 0 10#28 3 7 0 0 0 10#27 3 7 0 0 0 10#26 4 7 0 0 0 10#25 4 7 0 0 0 10#24 5 7 0 0 0 10#23 6 7 0 0 0 10#22 6 7 0 0 0 10#21 6 7 0 0 0 10#20 7 7 0 0 0 10#19 7 7 0 0 0 10#12 22 7 2 0 0 10#13 22 7 2 0 0 10#14 22 7 2 0 0 10#15 22 7 0 0 0 10#16 22 7 0 0 0 10#17 22 7 0 0 0 10#18 22 7 0 0 0 10#19 22 7 0 0 0 10#20 22 7 2 0 0 10#21 22 7 2 0 0 10#22 22 7 2 0 0 10#23 21 7 2 0 0 10#24 20 7 2 0 0 10#25 20 7 0 0 0 10#25 19 7 0 0 0 10#26 19 7 0 0 0 10#27 18 7 2 0 0 10#28 18 7 2 0 0 10#29 18 7 2 0 0 10#30 18 7 0 0 0 10#31 18 7 2 0 0 10#34 12 7 2 0 0 10#33 12 7 2 0 0 10#34 11 7 2 0 0 10#33 11 7 0 0 0 10#32 12 7 2 0 0 10#31 13 7 2 0 0 10#31 14 7 0 0 0 10#32 14 7 0 0 0 10#33 13 7 0 0 0 10#32 13 7 2 0 0 10#35 11 7 0 0 0 10#35 10 7 2 0 0 10#34 10 7 0 0 0 10#33 14 7 0 0 0 10#34 13 7 0 0 0 10#16 17 7 2 0 0 10#16 16 7 2 0 0 10#16 15 7 0 0 0 10#17 14 7 0 0 0 10#16 14 7 2 0 0 10#17 13 7 0 0 0 10#16 13 7 0 0 0 10#16 12 7 2 0 0 10#14 16 7 0 0 0 10#15 16 7 0 0 0 10#15 17 7 2 0 0 10#17 16 7 2 0 0 10#17 15 7 0 0 0 10#18 15 7 0 0 0 10#18 14 7 2 0 0 10#19 13 7 2 0 0 10#19 12 7 2 0 0 10#18 12 7 2 0 0 10#18 11 7 0 0 0 10#18 10 7 0 0 0 10#17 10 7 0 0 0 10#19 14 7 2 0 0 10#20 13 7 2 0 0 10#20 12 7 2 0 0 10#17 12 7 0 0 0 10#14 17 7 0 0 0 10#15 15 7 2 0 0 10#18 13 7 2 0 0 10#17 11 7 0 0 0 10#15 14 7 0 0 0 10#14 18 7 0 0 0 10#14 19 7 0 0 0 10#13 20 7 2 0 0 10#13 21 7 2 0 0 10#18 9 7 0 0 0 10#18 8 7 0 0 0 10#35 9 7 2 0 0 10#35 8 7 0 0 0 10#35 7 7 0 0 0 10#33 15 7 0 0 0 10#32 16 7 0 0 0 10#32 17 7 2 0 0 10#31 19 7 2 0 0 10#30 13 7 0 0 0 10#29 13 7 0 0 0 10#22 14 7 0 0 0 10#21 14 7 0 0 0 10#21 13 7 0 0 0 10#22 2 7 0 0 0 10#21 3 7 0 0 0 10#21 4 7 0 0 0 10#20 5 7 0 0 0 10#19 6 7 0 0 0 10#23 2 0 0 0 0 10#23 3 0 4 0 0 10#24 2 0 3 0 0 10#11 23 7 2 0 0 10#11 24 7 0 0 0 10#12 24 7 0 0 0 10#13 24 7 0 0 0 10#14 24 0 6 0 0 10#15 24 0 3 0 0 10#20 11 7 0 0 0 10#19 11 7 0 0 0 10#19 10 7 0 0 0 10#18 16 7 0 0 0 10#17 17 7 0 0 0 10#17 18 7 0 0 0 10#18 17 7 0 0 0 10"


colorFromInt : Int -> CellColor
colorFromInt int =
    case int of
        0 ->
            Green

        1 ->
            Red

        2 ->
            Blue

        3 ->
            Cyan

        4 ->
            Yellow

        5 ->
            Color1

        6 ->
            Purple

        _ ->
            Gray


objectFromInt : Int -> CellObject
objectFromInt int =
    case int of
        1 ->
            Pine

        2 ->
            Palm

        3 ->
            Town

        4 ->
            Tower

        5 ->
            Grave

        6 ->
            Farm

        7 ->
            StrongTower

        _ ->
            NoObject


point : Parser MapPosition
point =
    succeed (\x y -> ( x, y ))
        |. symbol "getFullLevelString() {"
        |. spaces
        |= int
        |. spaces
        |. symbol ","
        |. spaces
        |= int
        |. spaces
        |. symbol ")"


parseLevelFile : String -> String
parseLevelFile levelFile =
    Result.withDefault ""
        (run
            (succeed identity
                |. chompUntil "getFullLevelString() {"
                |. spaces
                |= (getChompedString <| chompWhile (\c -> c == '"'))
            )
            levelFile
        )


mapLevelFromAntiyoy : List Hex -> List Hex
mapLevelFromAntiyoy hexes =
    let
        minX =
            log "minX" <| Maybe.withDefault 0 <| List.minimum <| List.map (\hex -> Tuple.first hex.position) hexes

        minY =
            log "minY" <| Maybe.withDefault 0 <| List.minimum <| List.map (\hex -> Tuple.second hex.position) hexes

        maxX =
            log "maxX" <| Maybe.withDefault 0 <| List.maximum <| List.map (\hex -> Tuple.first hex.position) hexes

        maxY =
            log "maxY" <| Maybe.withDefault 0 <| List.maximum <| List.map (\hex -> Tuple.second hex.position) hexes
    in
    map2LevelFromAntiyoy <|
        List.map
            (\hex ->
                { hex
                    | position =
                        ( Tuple.second hex.position - minY, maxX - Tuple.first hex.position - (Tuple.second hex.position - minY + 1) // 2 )
                }
            )
            hexes


map2LevelFromAntiyoy : List Hex -> List Hex
map2LevelFromAntiyoy hexes =
    let
        minY =
            log "minY" <| Maybe.withDefault 0 <| List.minimum <| List.map (\hex -> Tuple.second hex.position) hexes
    in
    List.map
        (\hex ->
            { hex
                | position = ( Tuple.first hex.position, Tuple.second hex.position - minY )
            }
        )
        hexes


type alias AntiyoyHexLine =
    { index1 : Int
    , index2 : Int
    , colorIndex : Int
    , objectInside : Int
    , unitStrength : Int
    , readyToMove : Int
    , moveZoneNumber : Int
    }


getAntiyoyHexLine : List Int -> AntiyoyHexLine
getAntiyoyHexLine ints =
    case ints of
        [ index1, index2, colorIndex, objectIndex, unitStrength, readyToMove, moveZoneNumber ] ->
            AntiyoyHexLine index1 index2 colorIndex objectIndex unitStrength readyToMove moveZoneNumber

        _ ->
            todo ""


parseHexString : String -> Hex
parseHexString hexString =
    let
        antiyoyHexLine =
            log "antiyoyHexLine "
                (getAntiyoyHexLine <|
                    Result.withDefault [ floor 0, 0, 0, 0, 0, 0, 0 ] <|
                        run
                            (sequence
                                { start = ""
                                , separator = " "
                                , end = ""
                                , spaces = symbol ""
                                , item = int
                                , trailing = Optional
                                }
                            )
                            hexString
                )

        position =
            ( antiyoyHexLine.index1, antiyoyHexLine.index2 )

        objectInside =
            if antiyoyHexLine.unitStrength > 0 then
                Unit (antiyoyHexLine.unitStrength - 1) <| antiyoyHexLine.readyToMove == 1

            else
                objectFromInt antiyoyHexLine.objectInside
    in
    log "Hex " (Hex position (colorFromInt antiyoyHexLine.colorIndex) objectInside)


parseLevelString : String -> Level
parseLevelString levelString =
    let
        hexes =
            Result.withDefault ""
                (run
                    (succeed identity
                        |. chompUntil "/"
                        |. symbol "/"
                        |= (getChompedString <| chompUntilEndOr "\n")
                    )
                    levelString
                )

        hexesList =
            String.split "#" hexes
    in
    Level (mapLevelFromAntiyoy <| List.map parseHexString hexesList) Green
