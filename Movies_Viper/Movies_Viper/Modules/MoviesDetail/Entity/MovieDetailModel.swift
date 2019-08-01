//
//  MovieDetailModel.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/30/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation

struct MovieDetail: Decodable {
    let overview: String
    let credits: MovieCredits
    let posterPath: String
    let releaseDate: String
    let title:String
   
    private enum CodingKeys: CodingKey {
        case overview
        case credits
        case poster_path
        case release_date
        case original_title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.credits = try container.decode(MovieCredits.self, forKey: .credits)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .poster_path) ?? "www.google.com"
        self.releaseDate = try container.decode(String.self, forKey: .release_date)
        self.title = try container.decode(String.self, forKey: .original_title)
    }
}
