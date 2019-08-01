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
   
    private enum CodingKeys: CodingKey {
        case cast
        case crew
    }
    
    init(cast: [MovieCast], crew: [MovieCrew]) {
        self.cast = cast
        self.crew = crew
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cast = try container.decode([MovieCast].self, forKey: .cast)
        self.crew = try container.decode([MovieCrew].self, forKey: .crew)
    }

    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cast, forKey: .cast)
        try container.encode(crew, forKey: .crew)
       
    }
    
    
    
}
