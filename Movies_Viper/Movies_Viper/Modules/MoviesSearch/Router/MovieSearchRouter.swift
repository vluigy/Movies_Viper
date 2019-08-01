//
//  MovieSearchRouter.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 8/1/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation
import UIKit

class SearchRouter:PresenterToRouterSearchProtocol{

    static func createModule() -> MovieSearchViewController {
        let storyBoard = UIStoryboard(name: "Movies", bundle: nil)
        let view = storyBoard.instantiateViewController(withIdentifier: "MoviesSearch") as! MovieSearchViewController
        let presenter: ViewToPresenterSearchProtocol & InteractorToPresenterSearchProtocol = SearchPresenter()
        let interactor: PresenterToInteractorSearchProtocol = SearchInteractor()
        let router:PresenterToRouterSearchProtocol = SearchRouter()
        
    
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    
    func pushToMovieScreen(navigationConroller navigationController:UINavigationController,title: String) {
        let movieModue = SearchRouter.createModule()
        navigationController.pushViewController(movieModue,animated: true)
    }
    
}
