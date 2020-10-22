//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Beau Nouvelle on 2020-09-24.
//

import Foundation
import UIKit

class ForecastViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let apiService = WeatherAPIService()
    var forecast: Forecast?

    var city: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = city?.name
        tableView.register(HourlyTableViewCell.self, forCellReuseIdentifier: "CELL")
        tableView.rowHeight = UITableView.automaticDimension
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
            case .success(let forecast):
                self?.forecast = forecast
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            break
            }
        }
    }

}

extension ForecastViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Hourly Forecast"
        } else if section == 2 {
            return "Daily Forecast"
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 100
        }
        return UITableView.automaticDimension
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as? CurrentForecastTableViewCell else {
                return CurrentForecastTableViewCell()
            }

            cell.temperatureLabel.text = "\(forecast?.temp ?? -99999)"
            cell.mainLabel.text = "\(forecast?.weather.first?.main ?? "")"
            cell.weatherIconImageView?.image = UIImage(named: forecast?.weather.first?.icon ?? "01d")
            cell.weatherIconImageView.layer.cornerRadius = 5

            return cell
        } else if indexPath.section == 1 {
            let cell = HourlyTableViewCell(hourly: forecast?.hourly)
            return cell
        }

        return UITableViewCell()
    }

}

extension ForecastViewController: UITableViewDelegate {

}
