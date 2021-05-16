//
//  Utilities.swift
//  Weather App
//
//  Created by V L S RAVI on 16/05/21.
//

import Foundation

struct Utilities {
    static func getWeatherIcon(condition: Int) -> String {
        switch (condition) {
        case 0...300 :
            return "storm1"
        case 301...500 :
            return "light_rain"
        case 501...600 :
            return "much_rain"
        case 601...700 :
            return "snow1"
        case 701...771 :
            return "fog"
        case 772...799 :
            return "storm2"
        case 800 :
            return "sunny"
        case 801...804 :
            return "cloudy"
        case 900...903, 905...1000  :
            return "storm2"
        case 903 :
            return "snow2"
        case 904 :
            return "sunny"
        default :
            return "dont_know"
        }
    }
}
