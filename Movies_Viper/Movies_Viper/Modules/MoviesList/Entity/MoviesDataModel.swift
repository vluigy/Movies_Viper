//
//  MovieDataModel.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/31/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation

class MoviesData: Codable {
  
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [MoviesList]
    
    
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }

}
