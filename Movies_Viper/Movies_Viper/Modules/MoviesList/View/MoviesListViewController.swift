//
//  MoviesListViewController.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/30/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    var presentor:ViewToPresenterProtocol?
    
    @IBOutlet weak var uiTableView: UITableView!
    var noticeArrayList:[MoviesList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        presentor?.startFetchingNotice()
    }
}

extension MoviesListViewController:PresenterToViewProtocol{
    
    func showNotice(noticeArray: [MoviesList]) {
        self.noticeArrayList = noticeArray
    }
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Notice", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}



