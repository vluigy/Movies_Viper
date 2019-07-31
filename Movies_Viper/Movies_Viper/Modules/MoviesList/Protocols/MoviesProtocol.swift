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
    func showMovieController(navigationController:UINavigationController)
}

protocol PresenterToViewProtocol: class{
    //func showNotice(noticeArray:Array<NoticeModel>)
    func showNotice(noticeArray:Array<MoviesList>)
    func showError()
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> MoviesListViewController
//    static func createModule()-> NoticeViewController
    func pushToMovieScreen(navigationConroller:UINavigationController)
}

protocol PresenterToInteractorProtocol: class {
    var presenter:InteractorToPresenterProtocol? {get set}
    //func fetchNotice()
    func getList()
}

protocol InteractorToPresenterProtocol: class {
    //func noticeFetchedSuccess(noticeModelArray:Array<NoticeModel>)
    func noticeFetchedSuccess(noticeModelArray:Array<MoviesList>)
    func noticeFetchFailed()
}
