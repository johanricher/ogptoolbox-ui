// OGPToolbox-Editor -- Web editor for OGP toolbox
// By: Emmanuel Raviart <emmanuel.raviart@data.gouv.fr>
//
// Copyright (C) 2016 Etalab
// https://git.framasoft.org/etalab/ogptoolbox-editor
//
// OGPToolbox-Editor is free software you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// OGPToolbox-Editor is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.


import {
  categorySchema,
  featuresSchema as featuresSchemaOriginal, featuresUiSchema,
  usersTypesSchema, usersTypesUiSchema,
} from "./fields"


const featuresSchema = {
  ...featuresSchemaOriginal,
  "title": "Fonctionalities used by the project",
}


export const schema = {
  "title": "Project",
  "type": "object",
  "required": [
    "name",
  ],
  "properties": {
    "name": {
      "type": "string",
      "title": "Project official, commercial or common name"
    },
    "description_en": {
      "type": "string",
      "title": "Description"
    },
    "category": categorySchema,
    "features": featuresSchema,
    "url": {
      "type": "string",
      "title": "Project website (user interface or download link)"
    },
    "screenshots": {
      "type": "string",
      "title": "Screenshot(s) illustrating the main functionality(ies) of the project"
    },
    "actorName": {
      "type": "string",
      "title": "Project author official, commercial or common name"
    },
    "actorStatus": {
      "type": "array",
      "title": "Project author legal status",
      "items": {
        "type": "string",
      },
    },
    "actorEmail": {
      "type": "string",
      "title": "Project author e-mail adress"
    },
    "actorSize": {
      "type": "integer",
      "title": "Number of people contributing to the project"
    },
    "location": {
      "type": "string",
      "title": "Project location (country, region, etc)",
    },
    "scale": {
      "type": "array",
      "title": "Project scale",
      "items": {
        "type": "string",
        "enum": [
           "Local",
           "National",
           "International",
        ],
      },
    },
    "usersTypes": usersTypesSchema,
    "usersCount": {
      "type": "string",
      "title": "Number of users",
      "enum": [
        "",
        "1 - 10",
        "11 - 100",
        "101 - 1 000",
        "1 001 - 10 000",
        "10 001 - 100 000",
        "100 001 - 1 000 000",
        "> 1 000 000",
      ],
    },
    "customDevelopment": {
      "type": "boolean",
      "title": "Custom development"
    },
    "easeOfUse": {
      "type": "integer",
      "title": "Project ease of use (1 to 5 rating scale)",
      "minimum": 1,
      "maximum": 5,
    },
    "satisfactionLevel": {
      "type": "integer",
      "title": "Project satisfaction level (1 to 5 rating scale)",
      "minimum": 1,
      "maximum": 5,
    },
    "tools": {
      "type": "array",
      "title": "Tool(s) used by the project",
      "items": {
        "type": "string"
      }
    },
    "methods": {
      "type": "array",
      "title": "Method(s) used by the project",
      "items": {
        "type": "string"
      },
    },
  },
}

export const uiSchema = {
  // description_en: {
  //   "ui:widget": "textarea",
  // },
  "features": featuresUiSchema,
  "usersTypes": usersTypesUiSchema,
}