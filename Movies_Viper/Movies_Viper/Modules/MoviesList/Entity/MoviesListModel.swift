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
    let posterPath: String?
    let originalTitle: String
    let overview: String
    let releaseDate: String
    var posterImageUrl: String {
        return "https://image.tmdb.org/t/p/w300/\(posterPath ?? "")"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
    }

    init(id: Int, title: String, posterPath:String, originalTitle:String, overview:String, releaseDate:String) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.originalTitle = originalTitle
        self.overview = overview
        self.releaseDate = releaseDate
    }
    
}

