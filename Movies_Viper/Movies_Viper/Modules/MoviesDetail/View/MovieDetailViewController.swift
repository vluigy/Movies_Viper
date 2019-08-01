//
//  MovieDetailViewController.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/30/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    var detailMovie:MovieDetail?
    var moviePresenter:ViewToPresenterMovieProtocol?
    var id:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backAction(_:)))
        moviePresenter?.startFetchingMovie(id: id)
       // showProgressIndicator(view: self.view)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @objc func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MovieDetailViewController:PresenterToViewMovieProtocol{
    func onMovieResponseSuccess(movieDetailModel: MovieDetail) {
        var cast = ""
        var director = ""
        self.detailMovie = movieDetailModel
        self.summaryTextView.text = detailMovie?.overview
        let imageURL = URL(string: apiPathImages+detailMovie!.posterPath)
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(with: imageURL)
        detailMovie?.credits.cast.forEach({ (item) in
            if item.order <= 2{
                cast += item.name
                cast += ", "
            }
            if item.order == 3{
                cast += item.name
            }
        })
        self.castLabel.text = cast
        detailMovie?.credits.crew.forEach({ (item) in
            if item.job == "Director"{
                director = item.name
            }
        })
        
        self.directorLabel.text = director
        let yearString =  detailMovie?.releaseDate.components(separatedBy: "-")
        self.yearLabel.text = yearString?.first ?? "0000"
        let title = detailMovie?.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(backAction(_:)))
    }
    
    func onMovieResponseFailed(error: String) {
    
        //hideProgressIndicator(view: self.view)
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Notice", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}
