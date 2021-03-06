require 'rgeo'
require 'rgeo-geojson'
require 'json'

json = JSON.parse('{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "type": "Polygon",
        "coordinates": [
          [
            [
              37.577362060546875,
              55.910733545723346
            ],
            [
              37.613067626953125,
              55.903035707281575
            ],
            [
              37.684478759765625,
              55.90149595623592
            ],
            [
              37.74078369140625,
              55.87762199821965
            ],
            [
              37.79846191406249,
              55.845253201954556
            ],
            [
              37.835540771484375,
              55.81440069740049
            ],
            [
              37.841033935546875,
              55.74334702389655
            ],
            [
              37.8314208984375,
              55.683004338819316
            ],
            [
              37.8369140625,
              55.653572845133326
            ],
            [
              37.79571533203125,
              55.627220636248104
            ],
            [
              37.742156982421875,
              55.60472974085067
            ],
            [
              37.676239013671875,
              55.57756837218253
            ],
            [
              37.59796142578125,
              55.576792056834314
            ],
            [
              37.52655029296875,
              55.5892112606541
            ],
            [
              37.47711181640625,
              55.62411921078643
            ],
            [
              37.43316650390625,
              55.658996099428364
            ],
            [
              37.37823486328125,
              55.71164005362048
            ],
            [
              37.35626220703125,
              55.780434669338014
            ],
            [
              37.376861572265625,
              55.81440069740049
            ],
            [
              37.385101318359375,
              55.849108044401405
            ],
            [
              37.4139404296875,
              55.87454041761713
            ],
            [
              37.505950927734375,
              55.899186215063
            ],
            [
              37.53753662109374,
              55.90688481749484
            ],
            [
              37.577362060546875,
              55.910733545723346
            ]
          ]
        ]
      }
    }
  ]
}')


json = JSON.parse('{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "type": "Polygon",
        "coordinates": [
          [
            [
              37.39368438720703,
              55.556553924702854
            ],
            [
              37.39909172058105,
              55.561068368411846
            ],
            [
              37.40715980529785,
              55.55927236153912
            ],
            [
              37.39943504333496,
              55.55344690945121
            ],
            [
              37.39368438720703,
              55.556553924702854
            ]
          ]
        ]
      }
    }
  ]
}')

proj4 = '+proj=aea +lat_1=50 +lat_2=70 +lat_0=56 +lon_0=100 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs '
rus_f = RGeo::Geographic.projected_factory(projection_proj4: proj4)
features = RGeo::GeoJSON.decode(json, json_parser: :json)
projected = RGeo::Feature.cast features[0].geometry, factory: rus_f
p projected.area
p projected.centroid
