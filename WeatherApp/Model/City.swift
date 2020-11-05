//
//  City.swift
//  WeatherApp
//
//  Created by Beau Nouvelle on 2020-09-24.
//

import Foundation

struct City: Codable, Equatable {
    let name: String
    let lat: Double
    let lon: Double

    static func stored() -> City? {
        guard let data = UserDefaults.standard.data(forKey: "cityName") else {
             return nil
        }
        return try? JSONDecoder().decode(City.self, from: data)
    }

    var data: Data? {
        return try? JSONEncoder().encode(self)
    }
}
