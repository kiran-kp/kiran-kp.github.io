import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode
import Navigation
import Task exposing (Task)
import Markdown

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = (\_ -> Sub.none)
    }

-- MODEL
type alias Model =
  { body : Html Msg
  }

init : ( Model, Cmd Msg )
init =
  ( { body = text "Init val" }
  , getPageCmd
  )

-- UPDATE
type Msg
  = GetPageResult (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GetPageResult (Ok page) ->
        ( { model | body = Markdown.toHtml [ ]  page }
        , Cmd.none
        )

    GetPageResult (Err error) ->
        ( { model | body = text (toString error) }
        , Cmd.none
        )

getPageCmd : Cmd Msg
getPageCmd =
    Http.send GetPageResult <| Http.getString "Pages/main.md"

-- VIEW
view : Model -> Html Msg
view model =
    model.body
