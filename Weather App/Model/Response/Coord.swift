//
//  Coord.swift
//  Weather App
//
//  Created by V L S RAVI on 15/05/21.
//

import Foundation


struct Coord : Codable {
    let lat : Double?
    let lon : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case lat = "lat"
        case lon = "lon"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        lon = try values.decodeIfPresent(Double.self, forKey: .lon)
    }
    
}
