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
  
   private enum CodingKeys: String, CodingKey {
        case id = "cast_id"
        case name = "name"
        case order = "order"
    }

    init(id: Int, name: String, order:Int) {
        self.id = id
        self.name = name
        self.order = order
        
    }

}

