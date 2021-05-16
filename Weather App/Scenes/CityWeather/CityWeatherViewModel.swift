//
//  CityWeatherViewModel.swift
//  Weather App
//
//  Created by V L S RAVI on 15/05/21.
//

import Foundation

enum ViewState: Equatable {
    case loading
    case error(_ message: String)
    case updated
}


class CityWeatherViewModel {

    var state: ViewState = .updated {
        didSet {
            stateChange?(state)
        }
    }
    
    var stateChange: ((_ state: ViewState) -> Void)?

    var weatherData: WeatherData?

    //var weatherData: [City] = []

    let service = GetWeatherService(NetworkManager())

    //MARK: API calls
    /*func getWeatherData(city: [String : String]) {
        
        let urlComp = NSURLComponents(string: WEATHER_API)!
        var items = [URLQueryItem]()
        for (key,value) in parameter {
            items.append(URLQueryItem(name: key, value: value))
        }
        items = items.filter{!$0.name.isEmpty}
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if error == nil && data != nil {
                do {
                    let responseModel =  try JSONDecoder().decode(WeatherJSONData.self, from: data!)
                    DispatchQueue.main.async {
                        self.updateWeatherData (weatherData: responseModel)
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        self.showError()
                    }
                }
            }
            else if error != nil
            {
                DispatchQueue.main.async {
                    self.showError()
                }
            }
        })
        task.resume()
    }
    */
    
    func getWeatherData(for city: String) {
                
        state = .loading
        service.getWeatherForCity(city: city) {[weak self] (response) in
            switch response {
            case .success(let result):
                self?.weatherData = result.asEntity()
                self?.state = .updated
            case .failure(let error):
                self?.state = .error(error?.localizedDescription ?? "Unknown")
                print(error?.localizedDescription ?? "Unknown")
            }
        }
    }
    
    func getWeatherData(lat: String, long: String) {
                
        state = .loading
        service.getWeatherFor(lat: lat, long: long) {[weak self] (response) in
            switch response {
            case .success(let result):
                self?.weatherData = result.asEntity()
                self?.state = .updated
            case .failure(let error):
                self?.state = .error(error?.localizedDescription ?? "Unknown")
                print(error?.localizedDescription ?? "Unknown")
            }
        }
    }
}
