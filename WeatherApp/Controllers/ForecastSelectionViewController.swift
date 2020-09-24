//
//  ForecastSelectionViewController.swift
//  WeatherApp
//
//  Created by Beau Nouvelle on 2020-09-24.
//

import Foundation
import UIKit

class ForecastSelectionViewController: UIViewController {

    let apiService = WeatherAPIService()
    @IBOutlet weak var tempLabel: UILabel!

    var city: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = city?.name
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    func loadData() {
        guard let unwrappedCity = city else {
            return
        }
        apiService.getWeather(for: unwrappedCity) { [weak self] result in
            switch result {
            case .failure:
                break
            case .success(let weather):
                self?.tempLabel.text = String(format: "%.2f", weather.temp)
            }
        }
    }

}
