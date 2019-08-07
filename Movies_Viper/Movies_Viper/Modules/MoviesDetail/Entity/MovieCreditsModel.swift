//
//  CreditsMovieModel.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/31/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation

struct MovieCredits: Codable {
    let cast: [MovieCast]
    let crew: [MovieCrew]
   
   private enum CodingKeys: String, CodingKey {
        case cast = "cast"
        case crew = "crew"
    }
    
    init(cast: [MovieCast], crew: [MovieCrew]) {
        self.cast = cast
        self.crew = crew
    }
    
}
