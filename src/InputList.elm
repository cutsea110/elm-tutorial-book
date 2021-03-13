module InputList exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { input : String
    , memos : List String
    }


init : Model
init =
    { input = ""
    , memos = []
    }



-- UPDATE


type Msg
    = Input String
    | Submit
    | Delete Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input input ->
            { model
                | input = input
            }

        Submit ->
            { model
                | input = ""
                , memos = model.input :: model.memos
            }

        Delete idx ->
            { model
                | memos =
                    let
                        hd =
                            List.take idx model.memos

                        tl =
                            List.drop (idx + 1) model.memos
                    in
                    hd ++ tl
            }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Html.form [ onSubmit Submit ]
            [ input [ value model.input, onInput Input ] []
            , button [ disabled (String.length model.input < 1) ]
                [ text "Submit" ]
            ]
        , ul [] (List.indexedMap viewMemo model.memos)
        ]


viewMemo : Int -> String -> Html Msg
viewMemo idx memo =
    li [ onClick (Delete idx) ] [ text memo ]
