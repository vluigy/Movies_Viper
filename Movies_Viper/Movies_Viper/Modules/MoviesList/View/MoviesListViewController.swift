//
//  MoviesListViewController.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/30/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesListViewController: UIViewController {
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    var presentor:ViewToPresenterProtocol?
    var refreshControl = UIRefreshControl()
    var moviesList:[MoviesList] = []
    let cellIdentifier = "moviesCell"
    override func viewDidLoad() {
       super.viewDidLoad()
       self.hideOrShowElements(state: true)
       navigationController?.setNavigationBarHidden(true, animated: false)
       self.moviesCollectionView.register(UINib(nibName:"MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.dataSource = self
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        moviesCollectionView.addSubview(refreshControl)
        presentor?.startFetchingNotice()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func refreshData(){
      presentor?.startFetchingNotice()
      refreshControl.endRefreshing()
    }
    
    @IBAction func tryAgainButtonAction(_ sender: Any) {
        presentor?.startFetchingNotice()
    }
    
    func hideOrShowElements(state:Bool){
        self.moviesCollectionView.isHidden = state
        self.tryAgainButton.isHidden = !state
        
    }
    
}

extension MoviesListViewController:PresenterToViewProtocol{
    
    func showMovies(movies: [MoviesList]) {
        self.moviesList = movies
        self.moviesCollectionView.reloadData()
        self.hideOrShowElements(state: false)
        Loading.hide()
    }
    
    func showError(error:String) {
        let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        self.hideOrShowElements(state: true)
        Loading.hide()
    }
}

extension MoviesListViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = self.moviesList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MoviesCollectionViewCell
        let imageURL = URL(string: row.posterImageUrl)
        cell.movieImageView.kf.setImage(
            with: imageURL,
            placeholder: UIImage(named: "icon"),
            options: [.transition(.fade(0)), .loadDiskFileSynchronously]
        )
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/3, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = self.moviesList[indexPath.row].id
        presentor?.showMovieController(navigationController: navigationController!,id: id)

    }
    
}


