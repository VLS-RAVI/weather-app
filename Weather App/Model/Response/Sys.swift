//
//  Sys.swift
//  Weather App
//
//  Created by V L S RAVI on 15/05/21.
//

import Foundation

struct Sys : Codable {
    let type : Int?
    let message : Double?
    let sunset : Int?
    let sunrise : Int?
    let country : String?
    let id : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case type = "type"
        case message = "message"
        case sunset = "sunset"
        case sunrise = "sunrise"
        case country = "country"
        case id = "id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        message = try values.decodeIfPresent(Double.self, forKey: .message)
        sunset = try values.decodeIfPresent(Int.self, forKey: .sunset)
        sunrise = try values.decodeIfPresent(Int.self, forKey: .sunrise)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
    }
    
}
