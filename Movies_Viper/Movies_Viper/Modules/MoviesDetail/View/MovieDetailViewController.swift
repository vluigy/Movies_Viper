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

    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var yearTitleLabel: UILabel!
    @IBOutlet weak var directorTitleLabel: UILabel!
    @IBOutlet weak var castTitleLabel: UILabel!
    @IBOutlet weak var summaryTitleLabel: UILabel!
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
        self.hideOrShowElements(state: true)
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction(_:)))
        moviePresenter?.startFetchingMovie(id: id)
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
    
    func hideOrShowElements(state:Bool){
        self.posterImageView.isHidden = state
        self.summaryTextView.isHidden = state
        self.castLabel.isHidden = state
        self.directorLabel.isHidden = state
        self.yearLabel.isHidden = state
        self.summaryTitleLabel.isHidden = state
        self.castTitleLabel.isHidden = state
        self.yearTitleLabel.isHidden = state
        self.directorTitleLabel.isHidden = state
        self.tryAgainButton.isHidden = !state
    
    }
    @IBAction func tryAgainAction(_ sender: Any) {
        moviePresenter?.startFetchingMovie(id: id)
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
        self.hideOrShowElements(state: false)
        Loading.hide()
    }
    
    func onMovieResponseFailed(error: String) {
        self.hideOrShowElements(state: true)
        Loading.hide()
        let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}
