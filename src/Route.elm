module Route exposing (Route(..), parse)

import Url
import Url.Parser exposing ((</>), Parser, map, oneOf, string, top)


type Route
    = Top
    | User String
    | Repo String String


parse : Url.Url -> Maybe Route
parse url =
    Url.Parser.parse parser url


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Top top
        , map User string
        , map Repo (string </> string)
        ]
