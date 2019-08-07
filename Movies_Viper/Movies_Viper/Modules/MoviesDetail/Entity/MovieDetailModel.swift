//
//  MovieDetailModel.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/30/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation

struct MovieDetail: Codable {
    let overview: String
    let credits: MovieCredits
    let posterPath: String?
    let releaseDate: String
    let title:String
    let id:Int
    let backdropPath:String?
    var posterImageUrl: String {
        return "https://image.tmdb.org/t/p/w300/\(posterPath ?? "")"
    }
    
    var backdropImageUrl: String {
        return "https://image.tmdb.org/t/p/w500/\(backdropPath ?? "")"
    }

    private enum CodingKeys: String, CodingKey {
        case overview = "overview"
        case credits = "credits"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "original_title"
        case id = "id"
        case backdropPath  = "backdrop_path"

    }
    
    init(overview: String, credits: MovieCredits, posterPath: String,releaseDate: String,title: String, id:Int, backdropPath:String) {
         self.overview = overview
         self.credits = credits
         self.posterPath = posterPath
         self.releaseDate = releaseDate
         self.title = title
         self.id = id
         self.backdropPath = backdropPath
    }
    
}
