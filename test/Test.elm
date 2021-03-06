module Test exposing (..)

import ElmTest exposing (..)
import Dict
import Dict.Extra exposing (..)
import Set


main : Program Never
main =
    runSuite tests


tests : Test
tests =
    suite "Dict tests"
        [ groupByTests
        , removeWhenTests
        , removeManyTests
        , keepOnlyTests
        ]



-- groupBy


groupByTests : Test
groupByTests =
    suite "groupBy"
        [ test "example"
            <| assertEqual [ ( 1, [ jill, mary ] ), ( 2, [ jack ] ) ]
            <| Dict.toList (groupBy .groupId [ mary, jack, jill ])
        ]


type alias GroupByData =
    { groupId : Int
    , name : String
    }


mary : GroupByData
mary =
    GroupByData 1 "Mary"


jack : GroupByData
jack =
    GroupByData 2 "Jack"


jill : GroupByData
jill =
    GroupByData 1 "Jill"



-- removeWhen


removeWhenTests : Test
removeWhenTests =
    suite "removeWhen"
        [ test "example"
            <| assertEqual (Dict.fromList [ ( "Jack", 2 ) ])
            <| removeWhen (\_ v -> v == 1) (Dict.fromList [ ( "Mary", 1 ), ( "Jack", 2 ), ( "Jill", 1 ) ])
        ]



-- removeMany


removeManyTests : Test
removeManyTests =
    suite "removeMany"
        [ test "example"
            <| assertEqual (Dict.fromList [ ( "Jack", 2 ) ])
            <| removeMany (Set.fromList [ "Mary", "Jill" ]) (Dict.fromList [ ( "Mary", 1 ), ( "Jack", 2 ), ( "Jill", 1 ) ])
        ]



-- keepOnly


keepOnlyTests : Test
keepOnlyTests =
    suite "keepOnly"
        [ test "example"
            <| assertEqual (Dict.fromList [ ( "Jack", 2 ), ( "Jill", 1 ) ])
            <| keepOnly (Set.fromList [ "Jack", "Jill" ]) (Dict.fromList [ ( "Mary", 1 ), ( "Jack", 2 ), ( "Jill", 1 ) ])
        ]
