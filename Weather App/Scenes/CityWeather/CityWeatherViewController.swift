//
//  CityWeatherViewController.swift
//  Weather App
//
//  Created by V L S RAVI on 15/05/21.
//

import UIKit
import CoreLocation

class CityWeatherViewController: UIViewController {
    
    //MARK: Properties
    //IBOutlets
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    //Others
    let locationManager = CLLocationManager()
    let viewModel = CityWeatherViewModel()
    
    //MARK: View Lifecycle Methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupInterface()
        setupBindings()
    }
    
    //MARK: Initial setup
    private func setupInterface() {
        fetchCurrentLocation()
    }
    
    private func setupBindings() {
        viewModel.stateChange = {[weak self] state in
            DispatchQueue.main.async {
                
                switch state {
                case .error(let message):
                    //self?.loadingActivity.isHidden = true //rick
                    self?.showError()
                    print(message)
                case .loading:
                    //self?.loadingActivity.isHidden = false
                    //self?.loadingActivity.startAnimating()
                    break
                case .updated:
                    //self?.loadingActivity.isHidden = true
                    //self?.loadingActivity.stopAnimating()
                    self?.updateUI()
                    break
                }
            }
        }
    }
    
    //MARK: UI Updation
    func updateUI() {
        if let weatherData = viewModel.weatherData {
            cityLabel.text = weatherData.city
            temperatureLabel.text =  "\((weatherData.temperature)) ℃"
            weatherIcon.image = UIImage(named: weatherData.weatherIcon)
        } else {
            self.cityLabel.text = "Weather unavailable"
        }
        
    }
    
    func showError() {
        
        cityLabel.text = "Error in getting weather"
        weatherIcon.image = UIImage(named: "dunno")
        temperatureLabel.text = ""
    }
    
    //MARK: IBActions
    @IBAction func showCurrentLocation(_ sender: UIButton) {
        fetchCurrentLocation()
    }
    
    @IBAction func addToFavourites(_ sender: UIButton) {
        guard let weatherData = viewModel.weatherData else {return}
        CoreDataManager.shared.addCity(city: weatherData)
        
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowSelectCitySegue" {
            let destinationVC = segue.destination as! SelectCityViewController
            destinationVC.delegate = self
        } else if segue.identifier == "ShowFavouritesSegue" {
            guard let cities = CoreDataManager.shared.fetchCities() else {
                //show alert
                return
            }
            let destinationVC = segue.destination as! FavouriteCitiesViewController
            let fcViewModel = FavouriteCitiesViewModel(cities: cities)
            destinationVC.viewModel = fcViewModel
            destinationVC.delegate = self
        }
    }
    
    
}


extension CityWeatherViewController: CLLocationManagerDelegate {
    func fetchCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count-1]
        if location.horizontalAccuracy >  0 {
            
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            let lat = String(location.coordinate.latitude)
            let long = String(location.coordinate.longitude)
            viewModel.getWeatherData(lat: lat, long: long)
        }
        else{
            cityLabel.text = "Could not get accurate location !"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        cityLabel.text = "Could not get location"
    }
}

extension CityWeatherViewController: SelectCityDelegate {
    func citySelected(name: String) {

        if !name.trimmingCharacters(in: .whitespaces).isEmpty {
            viewModel.getWeatherData(for: name)
        }
    }

}
