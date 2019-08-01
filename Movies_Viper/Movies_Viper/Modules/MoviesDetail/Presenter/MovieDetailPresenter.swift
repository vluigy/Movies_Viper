//
//  MovieDetailPresenter.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/30/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation

class MoviePresenter:ViewToPresenterMovieProtocol{
    
    var view: PresenterToViewMovieProtocol?
    
    var interactor: PresenterToInteractorMovieProtocol?
    
    var router: PresenterToRouterMovieProtocol?
    
    func startFetchingMovie(id:Int) {
        interactor?.getDetail(id: id)
    }
    
}

extension MoviePresenter:InteractorToPresenterMovieProtocol{
    func movieFetchSuccess(movieDetailInteractor: MovieDetail) {
        view?.onMovieResponseSuccess(movieDetailModel: movieDetailInteractor)
    }
    
    func movieFetchFailed() {
        view?.onMovieResponseFailed(error: "Some Error message from api response")
    }
    
    
}
