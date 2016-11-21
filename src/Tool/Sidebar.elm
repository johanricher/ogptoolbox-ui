module Tool.Sidebar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Helpers exposing (aExternal, imgOfCard)
import Types exposing (..)


root : Card -> Html msg
root card =
    div [ class "col-md-3 sidebar" ]
        [ div [ class "row" ]
            [ div [ class "col-xs-12" ]
                [ div [ class "thumbnail orga grey" ]
                    [ div [ class "visual" ]
                        [ imgOfCard card ]
                    , div [ class "caption" ]
                        [ table [ class "table" ]
                            [ tbody []
                                [ tr [ class "editable" ]
                                    [ td [ class "table-label" ]
                                        [ text "Type" ]
                                    , td []
                                        [ text "Web Software" ]
                                    ]
                                , tr [ class "editable" ]
                                    [ td [ class "table-label" ]
                                        [ text "License" ]
                                    , td []
                                        [ text "Open-Source" ]
                                    ]
                                , tr [ class "editable" ]
                                    [ td [ class "table-label" ]
                                        [ text "Website" ]
                                    , td []
                                        (case getOneString "URL" card of
                                            Just url ->
                                                [ aExternal [ href url ] [ text url ] ]

                                            Nothing ->
                                                []
                                        )
                                    ]
                                , tr []
                                    [ td [ attribute "colspan" "2" ]
                                        [ button [ class "btn btn-default btn-action btn-block", type' "button" ]
                                            [ text "Use it" ]
                                        ]
                                    ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        , div [ class "row" ]
            [ div [ class "col-xs-12" ]
                [ div [ class "panel panel-default panel-side" ]
                    [ div [ class "panel-heading" ]
                        [ div [ class "row" ]
                            [ div [ class "col-xs-7 text-left" ]
                                [ h6 [ class "panel-title" ]
                                    [ text "Tags" ]
                                ]
                            , div [ class "col-xs-5 text-right up7" ]
                                [ button [ class "btn btn-default btn-xs btn-action", type' "button" ]
                                    [ text "Edit" ]
                                ]
                            ]
                        ]
                    , div [ class "panel-body" ]
                        (getManyStrings "Tag" card
                            |> List.map (\tag -> span [ class "label label-default label-tag" ] [ text tag ])
                        )
                    ]
                ]
            ]
        , div [ class "row" ]
            [ div [ class "col-xs-12" ]
                [ div [ class "panel panel-default panel-side" ]
                    [ div [ class "panel-heading" ]
                        [ div [ class "row" ]
                            [ div [ class "col-xs-7 text-left" ]
                                [ h6 [ class "panel-title" ]
                                    [ text "Similar tools" ]
                                ]
                            , div [ class "col-xs-5 text-right label-small" ]
                                [ text "Score" ]
                            ]
                        ]
                    , div [ class "panel-body chart" ]
                        [ table [ class "table" ]
                            [ tbody []
                                [ tr []
                                    [ th [ class "tool-icon-small", scope "row" ]
                                        [ img [ src "img/ckan.png" ]
                                            []
                                        , text "."
                                        ]
                                    , td []
                                        [ text "Udata" ]
                                    , td [ class "text-right label-small" ]
                                        [ text "50.367" ]
                                    ]
                                , tr []
                                    [ th [ class "tool-icon-small", scope "row" ]
                                        [ img [ src "img/consul.png" ]
                                            []
                                        ]
                                    , td []
                                        [ text "DKAN" ]
                                    , td [ class "text-right label-small" ]
                                        [ text "11.348" ]
                                    ]
                                , tr []
                                    [ th [ class "tool-icon-small", scope "row" ]
                                        [ img [ src "img/hackpad.png" ]
                                            []
                                        ]
                                    , td []
                                        [ text "OpenDataSoft" ]
                                    , td [ class "text-right label-small" ]
                                        [ text "7.032" ]
                                    ]
                                , tr []
                                    [ th [ class "tool-icon-small", scope "row" ]
                                        [ img [ src "img/ckan.png" ]
                                            []
                                        ]
                                    , td []
                                        [ text "Socrata Open Data" ]
                                    , td [ class "text-right label-small" ]
                                        [ text "3.456" ]
                                    ]
                                ]
                            ]
                        , button [ class "btn btn-default btn-xs btn-action btn-block", type' "button" ]
                            [ text "See all and compare" ]
                        ]
                    ]
                ]
            ]
        ]
