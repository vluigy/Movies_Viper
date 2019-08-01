//
//  MovieCastModel.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/31/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//
/*
 "cast_id": 0,
 "character": "Diana Prince / Wonder Woman",
 "credit_id": "543ff227c3a3680544000009",
 "gender": 1,
 "id": 90633,
 "name": "Gal Gadot",
 "order": 1,
 "profile_path": "/yV2nljqQa3MjrrIK4AllDjmJIcs.jpg"
 */
import Foundation

struct MovieCast: Decodable {
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
}

