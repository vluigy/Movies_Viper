//
//  CreditsMovieModel.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/31/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation

struct MovieCredits: Decodable {
    let cast: [MovieCast]
    let crew: [MovieCrew]
   
    private enum CodingKeys: CodingKey {
        case cast
        case crew
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cast = try container.decode([MovieCast].self, forKey: .cast)
        self.crew = try container.decode([MovieCrew].self, forKey: .crew)
    }
}
