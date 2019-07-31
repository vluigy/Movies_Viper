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
    
    var presentor:ViewToPresenterProtocol?
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    let cellIdentifier = "moviesCell"
    var moviesList:[MoviesList] = []
    
    override func viewDidLoad() {
       super.viewDidLoad()
       navigationController?.setNavigationBarHidden(true, animated: false)
       self.moviesCollectionView.register(UINib(nibName:"MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.dataSource = self
        presentor?.startFetchingNotice()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension MoviesListViewController:PresenterToViewProtocol{
    
    func showMovies(movies: [MoviesList]) {
        self.moviesList = movies
        self.moviesCollectionView.reloadData()
    }
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Notice", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        let imageURL = URL(string: apiPathImages+row.posterPath)
        cell.movieImageView.kf.indicatorType = .activity
        cell.movieImageView.kf.setImage(with: imageURL)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/3, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("touch")
      //  presentor?.showMovieController(navigationController: navigationController!)

    }
    
}


