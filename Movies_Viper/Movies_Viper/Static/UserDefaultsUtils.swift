//
//  UserDefaultsUtils.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/31/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation

struct UserDefaultsUtils {
    
    fileprivate static var ud: UserDefaults {
        return UserDefaults.init()
    }
    
    static func saveMovies(movies: [MoviesList]) {
        ud.set(try? PropertyListEncoder().encode(movies), forKey: "movies")
        ud.synchronize()
    }
    
    static func getMovies() -> [MoviesList] {
        if let data = ud.object(forKey: "movies") as? Data {
            do{
                return try PropertyListDecoder().decode(Array<MoviesList>.self, from: data)
            }catch{
                return []
            }
        }
        return []
    }
    
    static func saveMovieDetail(movies: [MovieDetail]) {
        let moviesInData = getMovieDetail()
        var moviesToSave:[MovieDetail] = []
        if moviesInData.count > 0 {
            let exist = moviesInData.filter({$0.id == movies[0].id})
            if exist.count == 0{
                moviesToSave = moviesInData
                moviesToSave.append(movies[0])
            }else{
                moviesToSave = moviesInData
            }
        }else{
            moviesToSave = movies
        }
        
        ud.set(try? PropertyListEncoder().encode(moviesToSave), forKey: "moviesDetail")
        ud.synchronize()
    }
    
    static func getMovieDetail() -> [MovieDetail] {
        if let data = ud.object(forKey: "moviesDetail") as? Data {
            do{
                return try PropertyListDecoder().decode(Array<MovieDetail>.self, from: data)
            }catch{
                return []
            }
        }
        return []
    }
    
}
