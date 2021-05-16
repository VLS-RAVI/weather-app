//
//  GetWeatherService.swift
//  Weather App
//
//  Created by V L S RAVI on 15/05/21.
//

import Foundation

enum GetWeatherServiceError: Error {
    case dataNotfound
}

class GetWeatherService: GetWeatherUseCase {
    
    var task: URLSessionTask?
    private let network: NetworkManager
    
    init(_ network: NetworkManager) {
        self.network = network
    }
    
    func getWeatherForCity(city: String, completion: @escaping (NetworkManager.Result<WeatherDataResponse>) -> Void) {
        let params : [String : String] = ["q" : city , "appid" : Constants.APP_ID]
        getWeatherData(for: params, completion: completion)
    }
    
    func getWeatherFor(lat: String, long: String,
                       completion: @escaping (_ result: NetworkManager.Result<WeatherDataResponse>) -> Void) {
        let params : [String : String] = ["lat" : lat , "lon" : long , "appid" : Constants.APP_ID]
        getWeatherData(for: params, completion: completion)
    }
    
    //MARK: Private Helper Methods
    private func getWeatherData(for params: [String:String],
                      completion: @escaping (_ result: NetworkManager.Result<WeatherDataResponse>) -> Void) {
        task?.cancel()
        let urlRequest = generateRequest(for: params)
        task = network.call(urlRequest: urlRequest, completion: completion)
    }
    
    private func generateRequest(for params: [String:String]) -> URLRequest {
        
        let urlComp = NSURLComponents(string: Constants.WEATHER_API_URL)!
        var items = [URLQueryItem]()
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }
        items = items.filter{!$0.name.isEmpty}
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = "GET"
        
        return urlRequest
    }
}
