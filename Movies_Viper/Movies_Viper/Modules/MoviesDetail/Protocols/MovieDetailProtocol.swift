//
//  MovieDetailProtocol.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/31/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation

protocol ViewToPresenterMovieProtocol:class{
    
    var view: PresenterToViewMovieProtocol? {get set}
    var interactor: PresenterToInteractorMovieProtocol? {get set}
    var router: PresenterToRouterMovieProtocol? {get set}
    func startFetchingMovie(id:Int)
    
}

protocol PresenterToViewMovieProtocol:class {
    
    func onMovieResponseSuccess(movieDetailModel:MovieDetail)
    func onMovieResponseFailed(error:String)
    
}

protocol PresenterToRouterMovieProtocol:class {
    
    static func createMovieModule(id:Int)->MovieDetailViewController
    
}

protocol PresenterToInteractorMovieProtocol:class {
    
    var presenter:InteractorToPresenterMovieProtocol? {get set}
    func getDetail(id:Int)
    
}

protocol InteractorToPresenterMovieProtocol:class {
    
    func movieFetchSuccess(movieDetailInteractor: MovieDetail)
    func movieFetchFailed(error:String)
    
}

