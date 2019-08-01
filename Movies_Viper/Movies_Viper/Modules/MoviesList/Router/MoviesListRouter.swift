//
//  MoviesListRouter.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/30/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation
import UIKit

class NoticeRouter:PresenterToRouterProtocol{
    
    static func createModule() -> MoviesListViewController {
        let storyBoard = UIStoryboard(name: "Movies", bundle: nil)
        let view = storyBoard.instantiateViewController(withIdentifier: "MoviesList") as! MoviesListViewController
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = NoticePresenter()
        let interactor: PresenterToInteractorProtocol = NoticeInteractor()
        let router:PresenterToRouterProtocol = NoticeRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func pushToMovieScreen(navigationConroller navigationController:UINavigationController,id:Int) {
        let movieModue = MovieRouter.createMovieModule(id:id)
        navigationController.pushViewController(movieModue,animated: true)
    }
    
}
