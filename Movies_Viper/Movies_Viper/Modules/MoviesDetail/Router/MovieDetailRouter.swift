//
//  MovieDetailRouter.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/30/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation
import UIKit

class MovieRouter:PresenterToRouterMovieProtocol{
    
    static func createMovieModule(id:Int) -> MovieDetailViewController {
      
        let storyBoard = UIStoryboard(name: "Movies", bundle: nil)
        let view = storyBoard.instantiateViewController(withIdentifier: "MovieDetail") as! MovieDetailViewController
       
        let presenter: ViewToPresenterMovieProtocol & InteractorToPresenterMovieProtocol = MoviePresenter()
        let interactor: PresenterToInteractorMovieProtocol = MovieInteractor()
        let router:PresenterToRouterMovieProtocol = MovieRouter()
        
        view.moviePresenter = presenter
        view.id = id
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
}

