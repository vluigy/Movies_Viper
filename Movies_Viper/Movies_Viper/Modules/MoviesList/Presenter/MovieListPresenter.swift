//
//  MovieListPresenter.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/30/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation
import UIKit

class NoticePresenter:ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func startFetchingNotice() {
        Loading.show()
        interactor?.getList()
    }
    
    func showMovieController(navigationController: UINavigationController,id:Int) {
        router?.pushToMovieScreen(navigationConroller:navigationController, id:id)
    }
    
}

extension NoticePresenter: InteractorToPresenterProtocol{
    
    func moviesFetchedSuccess(moviesModelArray: Array<MoviesList>) {
        view?.showMovies(movies: moviesModelArray)
    }
    
    func moviesListFetchFailed(error:String) {
        view?.showError(error: error)
    }
    
}
