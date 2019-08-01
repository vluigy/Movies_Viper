//
//  MovieSearchViewController.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 8/1/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let cellIdentifier = "Cell"
    var movies:[MoviesList] = []
    var presentor:ViewToPresenterSearchProtocol?
    var detail:ViewToPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction(_:)))
        moviesTableView.register(UINib(nibName: "MoviesTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)

        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.tableFooterView = UIView(frame: .zero)
        searchBar.delegate = self
        searchBar.backgroundColor = UIColor.black
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.orange
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor.orange
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchBar.becomeFirstResponder()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension MovieSearchViewController:PresenterToViewSearchProtocol{
    func showMovies(movies: Array<MoviesList>) {
        self.movies = movies
        self.moviesTableView.reloadData()
        Loading.hide()
    }
    
    func showError(error: String) {
        Loading.hide()
        let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MovieSearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        
        if self.searchBar.text! != ""{
        let originalString = self.searchBar.text!
        let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        presentor?.startFetchingNotice(title: escapedString!)
        }
    }

}

extension MovieSearchViewController:UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let row = self.movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MoviesTableViewCell
        let yearString =  row.releaseDate.components(separatedBy: "-")
        cell.nameLabel.text = row.originalTitle
        cell.yearLabel.text = yearString.first ?? "0000"
        let imageURL = URL(string: row.posterImageUrl)
        cell.movieImageView.kf.setImage(
            with: imageURL,
            placeholder: UIImage(named: "icon"),
            options: [.transition(.fade(0)), .loadDiskFileSynchronously]
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let id = self.movies[indexPath.row].id
         self.navigationController?.isNavigationBarHidden = false
         let route =  NoticeRouter.createModule()//MovieRouter.createMovieModule(id: id)
         route.presentor?.showMovieController(navigationController: navigationController!, id: id)
    }
    
}

