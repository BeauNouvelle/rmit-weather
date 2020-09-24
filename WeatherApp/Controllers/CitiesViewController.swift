//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by Beau Nouvelle on 2020-09-24.
//

import UIKit

class CitiesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var selectedCity: City?

    let cities = [
        City(name: "Melbourne", lat: -37.81, lon: 144.96)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cities"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ForecastSelectionViewController {
            destination.city = selectedCity
        }
    }
}

extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        self.selectedCity = city
    }
}

extension CitiesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = city.name
        return cell
    }
}