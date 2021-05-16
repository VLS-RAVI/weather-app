//
//  Weather.swift
//  Weather App
//
//  Created by V L S RAVI on 15/05/21.
//

import Foundation

struct Weather : Codable {
    let icon : String?
    let description : String?
    let main : String?
    let id : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case icon = "icon"
        case description = "description"
        case main = "main"
        case id = "id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        main = try values.decodeIfPresent(String.self, forKey: .main)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
    }
    
}
