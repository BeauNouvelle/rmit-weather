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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as? HourlyTableViewCell else {
            return UITableViewCell()
        }


        return cell
    }

}

extension ForecastViewController: UITableViewDelegate {

}
