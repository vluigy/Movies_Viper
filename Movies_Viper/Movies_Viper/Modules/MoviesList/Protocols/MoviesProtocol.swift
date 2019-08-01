//
//  MoviesProtocol.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/30/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: class{
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingNotice()
    func showMovieController(navigationController:UINavigationController, id:Int)
}

protocol PresenterToViewProtocol: class{
    //func showNotice(noticeArray:Array<NoticeModel>)
    func showMovies(movies:Array<MoviesList>)
    func showError(error:String)
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> MoviesListViewController
//    static func createModule()-> NoticeViewController
    func pushToMovieScreen(navigationConroller:UINavigationController,id:Int)
}

protocol PresenterToInteractorProtocol: class {
    var presenter:InteractorToPresenterProtocol? {get set}
    //func fetchNotice()
    func getList()
}

protocol InteractorToPresenterProtocol: class {
    //func noticeFetchedSuccess(noticeModelArray:Array<NoticeModel>)
    func moviesFetchedSuccess(moviesModelArray:Array<MoviesList>)
    func moviesListFetchFailed(error:String)
}
