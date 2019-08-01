//
//  MovieDataModel.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/31/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation
struct MoviesData: Decodable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [MoviesList]
    
    
    private enum CodingKeys: CodingKey {
        case page
        case total_results
        case total_pages
        case results
        
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decode(Int.self, forKey: .page)
        self.totalResults = try container.decode(Int.self, forKey: .total_results)
        self.totalPages = try container.decode(Int.self, forKey: .total_pages)
        self.results = try container.decode([MoviesList].self, forKey: .results)
        
    }
}
