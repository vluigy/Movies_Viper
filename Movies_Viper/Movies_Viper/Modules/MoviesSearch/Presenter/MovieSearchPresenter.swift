//
//  MovieSearchPresenter.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 8/1/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation
import UIKit

class SearchPresenter:ViewToPresenterSearchProtocol{
    
    
    var view: PresenterToViewSearchProtocol?
    
    var interactor: PresenterToInteractorSearchProtocol?
    
    var router: PresenterToRouterSearchProtocol?
    
    func startFetchingNotice(title:String) {
        Loading.show()
        interactor?.getList(title: title)
    }
    
    func showMovieController(navigationController: UINavigationController,title:String) {
        router?.pushToMovieScreen(navigationConroller:navigationController,title:title)
    }
    
}

extension SearchPresenter:InteractorToPresenterSearchProtocol{
    func moviesFetchedSuccess(moviesModelArray: Array<MoviesList>) {
       view?.showMovies(movies: moviesModelArray)
    }
    
    func moviesListFetchFailed(error: String) {
       // view?.onMovieResponseFailed(error: error)
        view?.showError(error: error)
    }

    
}
