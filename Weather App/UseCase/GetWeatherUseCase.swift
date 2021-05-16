//
//  GetWeatherUseCase.swift
//  Weather App
//
//  Created by V L S RAVI on 15/05/21.
//

import Foundation

protocol GetWeatherUseCase {
    func getWeatherForCity(city: String,
                      completion: @escaping (_ result: NetworkManager.Result<WeatherDataResponse>) -> Void)
    
    func getWeatherFor(lat: String, long: String,
                      completion: @escaping (_ result: NetworkManager.Result<WeatherDataResponse>) -> Void)
}
