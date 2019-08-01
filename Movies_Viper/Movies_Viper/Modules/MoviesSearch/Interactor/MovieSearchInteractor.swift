//
//  MovieSearchInteractor.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 8/1/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation
import Alamofire


enum MoviesActionSearch {
    case getMoviesList
}

extension MoviesActionSearch: Endpoint {
    var base: String {
        return apiDomain
    }
    var path: String {
        switch self {
        case .getMoviesList: return "discover/movie?\(apiKey)"
        }
    }
}


class SearchInteractor: PresenterToInteractorSearchProtocol{
  
    var presenter: InteractorToPresenterSearchProtocol?
    
    func getList(title:String){
        self.getDetailRequest(title: title) { [weak self] response in
            guard let _ = self else {return}
            switch response {
            case .success(let result):
                self?.presenter?.moviesFetchedSuccess(moviesModelArray: result.results)
                break
            case .error(let result):
                    self?.presenter?.moviesListFetchFailed(error: result.message + " " + result.code)
                
                break
            }
        }
    }
    
    
    func getDetailRequest(title:String, completion: @escaping (_ response: ModelResponse<MoviesData>) -> Void) {
        let values = ["title": title]
        Connection.send(endpoint: MoviesActionSearch.getMoviesList, values: values) { (response) in
            switch response {
            case .success(let result):
                do {
                    let decoded = try JSONDecoder().decode(MoviesData.self, from: result)
                    if decoded.results.count > 0 {
                        completion(.success(result: decoded))
                    } else {
                        completion(.error(result: Error(code: "SM1001", message: "Invalid Data")))
                    }
                } catch {
                    completion(.error(result: Error.init(code: "SM1000", message: Errors.errorServer)))
                }
                break
            case .failure:
                completion(.error(result: Error.init(code: "SM2000", message: Errors.errorConnection)))
                break
            case .responseUnsuccessful(let code):
                if code == 412 {
                    completion(.error(result: Error.init(code: "SM4000", message: Errors.errorSecurity)))
                } else if code == -1009 {
                    completion(.error(result: Error.init(code: "SM3000", message: Errors.errorConnection)))
                } else {
                    completion(.error(result: Error.init(code: "SM1001", message: Errors.errorServer)))
                }
                
                break
            case .invalidData:
                completion(.error(result: Error.init(code: "SM1002", message: Errors.errorServer)))
                break
            }
        }
    }
}

