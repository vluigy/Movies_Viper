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
        interactor?.getList()
    }
    
    func showMovieController(navigationController: UINavigationController) {
        router?.pushToMovieScreen(navigationConroller:navigationController)
    }
    
}

extension NoticePresenter: InteractorToPresenterProtocol{
    
    func noticeFetchedSuccess(noticeModelArray: Array<MoviesList>) {
        view?.showNotice(noticeArray: noticeModelArray)
    }
    
    func noticeFetchFailed() {
        view?.showError()
    }
    
}
