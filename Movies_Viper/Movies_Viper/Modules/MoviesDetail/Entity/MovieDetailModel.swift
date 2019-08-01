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

   
    private enum CodingKeys: CodingKey {
        case overview
        case credits
        case poster_path
        case release_date
        case original_title
        case id
        case backdrop_path
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.credits = try container.decode(MovieCredits.self, forKey: .credits)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .poster_path)
        self.releaseDate = try container.decode(String.self, forKey: .release_date)
        self.title = try container.decode(String.self, forKey: .original_title)
        self.id = try container.decode(Int.self, forKey: .id)
        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdrop_path)

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
    

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(overview, forKey: .overview)
        try container.encode(credits, forKey: .credits)
        try container.encode(posterPath, forKey: .poster_path)
        try container.encode(releaseDate, forKey: .release_date)
        try container.encode(title, forKey: .original_title)
        try container.encode(id, forKey: .id)
        try container.encode(backdropPath, forKey: .backdrop_path)
    }
    
    
}
