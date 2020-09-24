//
//  Weather.swift
//  WeatherApp
//
//  Created by Beau Nouvelle on 2020-09-24.
//

import Foundation

struct Weather: Decodable {

    static let url = URL(string: "")!

    let dt: TimeInterval
    let sunrise: TimeInterval
    let sunset: TimeInterval
    let temp: Double

    enum CodingKeys: String, CodingKey {
        case current
        case dt
        case sunrise
        case sunset
        case temp
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let currentContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .current)
        dt = try currentContainer.decode(TimeInterval.self, forKey: .dt)
        sunrise = try currentContainer.decode(TimeInterval.self, forKey: .sunrise)
        sunset = try currentContainer.decode(TimeInterval.self, forKey: .sunset)
        temp = try currentContainer.decode(Double.self, forKey: .temp)
    }
}

//    "feels_like": 293.82,
//    "pressure": 1016,
//    "humidity": 100,
//    "dew_point": 293.28,
//    "uvi": 10.64,
//    "clouds": 90,
//    "visibility": 10000,
//    "wind_speed": 4.6,
//    "wind_deg": 310,
//    "weather": [
//      {
//        "id": 501,
//        "main": "Rain",
//        "description": "moderate rain",
//        "icon": "10n"
//      },
//      {
//        "id": 201,
//        "main": "Thunderstorm",
//        "description": "thunderstorm with rain",
//        "icon": "11n"
//      }
//    ],
//    "rain": {
//      "1h": 2.93
//    }
//  },
//  "minutely": [
//    {
//      "dt": 1595243460,
//      "precipitation": 2.928
//    },
//    ...
//  },
