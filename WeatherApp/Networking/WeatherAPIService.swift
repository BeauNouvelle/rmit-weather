//
//  WeatherAPIService.swift
//  WeatherApp
//
//  Created by Beau Nouvelle on 2020-09-24.
//

import Foundation

class WeatherAPIService {

    let baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/onecall")!

    func getWeather(for city: City, completion: @escaping (Result<Weather, Error>) -> ()) {
        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)

        #warning("Replace Your Key")
        let queries = [URLQueryItem(name: "lat", value: "\(city.lat)"),
                       URLQueryItem(name: "lon", value: "\(city.lon)"),
                       URLQueryItem(name: "appid", value: "YOUR_KEY")]

        urlComponents?.queryItems = queries

        guard let url = urlComponents?.url else {
            print("Could not create url")
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let validData = data else {
                print("no data")
                return
            }
            DispatchQueue.main.async {
                do {
                    let weather = try JSONDecoder().decode(Weather.self, from: validData)
                    completion(.success(weather))
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .resume()
    }
}
