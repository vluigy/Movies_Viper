//
//  MovieSearchProtocol.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 8/1/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//


import Foundation
import UIKit

protocol ViewToPresenterSearchProtocol: class{
    var view: PresenterToViewSearchProtocol? {get set}
    var interactor: PresenterToInteractorSearchProtocol? {get set}
    var router: PresenterToRouterSearchProtocol? {get set}
    func startFetchingNotice(title:String)
    func showMovieController(navigationController:UINavigationController, title:String)
}

protocol PresenterToViewSearchProtocol: class{
    func showMovies(movies:Array<MoviesList>)
    func showError(error:String)
}



protocol PresenterToRouterSearchProtocol: class {
    static func createModule()-> MovieSearchViewController
    func pushToMovieScreen(navigationConroller:UINavigationController, title:String)
}

protocol PresenterToInteractorSearchProtocol: class {
    var presenter:InteractorToPresenterSearchProtocol? {get set}
    func getList(title:String)
}

protocol InteractorToPresenterSearchProtocol: class {
    func moviesFetchedSuccess(moviesModelArray:Array<MoviesList>)
    func moviesListFetchFailed(error:String)
}
