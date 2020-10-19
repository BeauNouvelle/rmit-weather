//
//  Forecast.swift
//  WeatherApp
//
//  Created by Beau Nouvelle on 2020-09-24.
//

import Foundation

struct Forecast: Decodable {

    static let url = URL(string: "")!

    let dt: TimeInterval
    let sunrise: TimeInterval
    let sunset: TimeInterval
    let temp: Double
    let weather: [Weather]
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case current
        case daily

        case dt
        case sunrise
        case sunset
        case temp
        case weather
    }

    init(from decoder: Decoder) throws {
        let root = try decoder.container(keyedBy: CodingKeys.self)
        daily = try root.decode([Daily].self, forKey: .daily)

        let currentContainer = try root.nestedContainer(keyedBy: CodingKeys.self, forKey: .current)
        dt = try currentContainer.decode(TimeInterval.self, forKey: .dt)
        sunrise = try currentContainer.decode(TimeInterval.self, forKey: .sunrise)
        sunset = try currentContainer.decode(TimeInterval.self, forKey: .sunset)
        temp = try currentContainer.decode(Double.self, forKey: .temp)
        weather = try currentContainer.decode([Weather].self, forKey: .weather)
    }
}

struct Temp: Decodable {
    let min: Double
    let max: Double
}

struct Daily: Decodable {
    let weather: [Weather]
    let temp: Temp
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
