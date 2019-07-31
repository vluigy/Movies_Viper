//
//  MoviesListModel.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/30/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation

struct MoviesList: Decodable {
    let voteCount: Int
    let id: Int
    let voteAverage: Double
    let title: String
    let popularity: Double
    let posterPath: String
    let originalLanguage: String
    let originalTitle: String
    let genreIds: [Int]
    let backdropPath: String
    let overview: String
    let releaseDate: String
    var imageData: Data?
    
    private enum CodingKeys: CodingKey {
        case vote_count
        case id
        case vote_average
        case title
        case popularity
        case poster_path
        case original_language
        case original_title
        case genre_ids
        case backdrop_path
        case overview
        case release_date
        
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.voteCount = try container.decode(Int.self, forKey: .vote_count)
        self.id = try container.decode(Int.self, forKey: .id)
        self.voteAverage = try container.decode(Double.self, forKey: .vote_average)
        self.title = try container.decode(String.self, forKey: .title)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.posterPath = try container.decode(String.self, forKey: .poster_path)
        self.originalLanguage = try container.decode(String.self, forKey: .original_language)
        self.originalTitle = try container.decode(String.self, forKey: .original_title)
        self.genreIds = try container.decode([Int].self, forKey: .genre_ids)
        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdrop_path) ?? "www.google.com"
        self.overview = try container.decode(String.self, forKey: .overview)
        self.releaseDate = try container.decode(String.self, forKey: .release_date)
    }
}

