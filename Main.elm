import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode
import Navigation
import Task exposing (Task)

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = (\_ -> Sub.none)
    }

-- MODEL
type alias Model =
  { body : String
  }

init : ( Model, Cmd Msg )
init =
  ( { body = "Init val" }
  , getPageCmd
  )

-- UPDATE
type Msg
  = GetPageResult (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GetPageResult (Ok page) ->
        ( { model | body = page }
        , Cmd.none
        )

    GetPageResult (Err page) ->
        ( { model | body = "error fails" }
        , Cmd.none
        )

getPageCmd : Cmd Msg
getPageCmd =
    Http.send GetPageResult <| Http.get "Pages/main.json" parsePage

parsePage =
    Decode.at [ "body" ] Decode.string

-- VIEW
view : Model -> Html msg
view model =
    text model.body
