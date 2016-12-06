module Decoders exposing (..)

import Dict exposing (Dict)
import Json.Decode exposing (..)
import Json.Decode.Extra exposing ((|:))
import String
import Types exposing (..)


bijectiveCardReferenceDecoder : Decoder BijectiveCardReference
bijectiveCardReferenceDecoder =
    succeed BijectiveCardReference
        |: ("targetId" := string)
        |: ("reverseKeyId" := string)


popularTagDecoder : Decoder PopularTag
popularTagDecoder =
    succeed PopularTag
        |: ("count" := (string `customDecoder` String.toFloat))
        |: ("tagId" := string)


popularTagsDataDecoder : Decoder PopularTagsData
popularTagsDataDecoder =
    ("data"
        := (succeed PopularTagsData
                |: ("popularity" := list popularTagDecoder)
                |: (oneOf [ ("values" := dict valueDecoder), succeed Dict.empty ])
           )
    )


cardDecoder : Decoder Card
cardDecoder =
    succeed Card
        |: ("createdAt" := string)
        |: oneOf [ ("deleted" := bool), succeed False ]
        |: ("id" := string)
        |: ("properties" := dict string)
        |: oneOf [ ("rating" := int), succeed 0 ]
        |: oneOf [ ("ratingCount" := int), succeed 0 ]
        |: oneOf [ ("ratingSum" := int), succeed 0 ]
        |: oneOf [ ("references" := dict (list string)), succeed Dict.empty ]
        |: ("subTypeIds" := list string)
        |: oneOf [ ("tags" := list (dict string)), succeed [] ]
        |: ("type" := string)


dataIdDecoder : Decoder DataId
dataIdDecoder =
    succeed DataId
        |: ("cards" := dict cardDecoder)
        |: ("id" := string)
        |: oneOf [ ("values" := dict valueDecoder), succeed Dict.empty ]


dataIdBodyDecoder : Decoder DataIdBody
dataIdBodyDecoder =
    succeed DataIdBody
        |: ("data" := dataIdDecoder)


dataIdsDecoder : Decoder DataIds
dataIdsDecoder =
    object2 (,)
        ("ids" := list string)
        (oneOf [ ("users" := dict userDecoder), succeed Dict.empty ])
        `andThen`
            (\( ids, users ) ->
                (if List.isEmpty ids then
                    succeed ( Dict.empty, Dict.empty )
                 else
                    object2 (,)
                        ("cards" := dict cardDecoder)
                        ("values" := dict valueDecoder)
                )
                    |> map (\( cards, values ) -> DataIds cards ids users values)
            )


dataIdsBodyDecoder : Decoder DataIdsBody
dataIdsBodyDecoder =
    succeed DataIdsBody
        |: ("count" := string `customDecoder` String.toInt)
        |: ("data" := dataIdsDecoder)
        |: ("limit" := int)
        |: ("offset" := int)


messageBodyDecoder : Decoder String
messageBodyDecoder =
    ("data" := string)


userBodyDecoder : Decoder UserBody
userBodyDecoder =
    succeed UserBody
        |: ("data" := userDecoder)


userDecoder : Decoder User
userDecoder =
    succeed User
        |: ("activated" := bool)
        |: ("apiKey" := string)
        |: ("email" := string)
        |: ("name" := string)
        |: ("urlName" := string)


userForPortDecoder : Decoder User
userForPortDecoder =
    succeed User
        -- Workaround a bug in ports that removes boolean values.
        |:
            (("activated" := string)
                `andThen`
                    (\activated ->
                        succeed (not (String.isEmpty activated))
                    )
            )
        |: ("apiKey" := string)
        |: ("email" := string)
        |: ("name" := string)
        |: ("urlName" := string)


valueDecoder : Decoder Types.Value
valueDecoder =
    object5 (,,,,)
        ("createdAt" := string)
        ("id" := string)
        ("schemaId" := string)
        ("type" := string)
        (oneOf [ ("widgetId" := string), succeed "" ])
        `andThen`
            (\( createdAt, id, schemaId, type_, widgetId ) ->
                ("value" := valueValueDecoder schemaId)
                    |> map (\value -> Types.Value createdAt id schemaId type_ value widgetId)
            )


valueValueDecoder : String -> Decoder ValueType
valueValueDecoder schemaId =
    let
        decoder =
            case schemaId of
                "schema:bijective-card-reference" ->
                    bijectiveCardReferenceDecoder |> map BijectiveCardReferenceValue

                "schema:card-id" ->
                    string |> map CardIdValue

                "schema:card-ids-array" ->
                    list string |> map CardIdArrayValue

                "schema:localized-string" ->
                    dict string |> map LocalizedStringValue

                "schema:number" ->
                    float |> map NumberValue

                "schema:string" ->
                    string |> map StringValue

                "schema:uri" ->
                    string |> map StringValue

                "schema:value-ids-array" ->
                    list string |> map ValueIdArrayValue

                _ ->
                    fail ("TODO Unsupported schemaId: " ++ schemaId)
    in
        oneOf
            [ decoder
            , value
                |> map
                    (\value ->
                        let
                            str =
                                toString value

                            -- _ =
                            --     Debug.log ("WrongValue \"" ++ str ++ "\", schemaId: " ++ schemaId)
                        in
                            WrongValue str schemaId
                    )
            ]
