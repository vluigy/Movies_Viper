//
//  MovieCastModel.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/31/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation

struct MovieCast: Codable {
    let id: Int
    let name: String
    let order: Int
  
    private enum CodingKeys: CodingKey {
        case cast_id
        case name
        case order
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .cast_id)
        self.name = try container.decode(String.self, forKey: .name)
        self.order = try container.decode(Int.self, forKey: .order)
    }
    
    init(id: Int, name: String, order:Int) {
        self.id = id
        self.name = name
        self.order = order
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .cast_id)
        try container.encode(name, forKey: .name)
        try container.encode(order, forKey: .order)
        
    }
}

