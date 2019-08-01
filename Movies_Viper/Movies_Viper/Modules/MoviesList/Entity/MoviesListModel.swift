//
//  MoviesListModel.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/30/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation

struct MoviesList: Codable {
    let id: Int
    let title: String
    let posterPath: String
    let originalTitle: String
    let overview: String
    let releaseDate: String
    
    private enum CodingKeys: CodingKey {
        case id
        case title
        case poster_path
        case original_title
        case overview
        case release_date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.posterPath = try container.decode(String.self, forKey: .poster_path)
        self.originalTitle = try container.decode(String.self, forKey: .original_title)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.releaseDate = try container.decode(String.self, forKey: .release_date)
    }
    
    init(id: Int, title: String, posterPath:String, originalTitle:String, overview:String, releaseDate:String) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.originalTitle = originalTitle
        self.overview = overview
        self.releaseDate = releaseDate
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(posterPath, forKey: .poster_path)
        try container.encode(originalTitle, forKey: .original_title)
        try container.encode(overview, forKey: .overview)
        try container.encode(releaseDate, forKey: .release_date)
    }
    
}

