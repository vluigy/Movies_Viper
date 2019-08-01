//
//  MovieDetailInteractor.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/30/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation
import Alamofire

var idMovie:Int = 0

enum MoviesDetailAction {
    case getMovieDetail
}

extension MoviesDetailAction: Endpoint {
    
    var base: String {
        return apiDomain
    }
    var path: String {
        switch self {
        case .getMovieDetail: return "movie/\(idMovie)?\(apiKey)&append_to_response=credits"
        }
    }
    
}

class MovieInteractor:PresenterToInteractorMovieProtocol{
    
    var presenter: InteractorToPresenterMovieProtocol?
    
    func getDetail(id:Int){
        self.getDetailRequest(id: id) { [weak self] response in
            idMovie = id
        
            guard let _ = self else {return}
            switch response {
            case .success(let result):
                //self?.presenter?.moviesFetchedSuccess(moviesModelArray: result.results)
                self?.presenter?.movieFetchSuccess(movieDetailInteractor: result)
                break
            case .error(_):
                //self?.presenter?.noticeFetchFailed()
                self?.presenter?.movieFetchFailed()
                break
            }
        }
    }
    
    func getDetailRequest(id:Int, completion: @escaping (_ response: ModelResponse<MovieDetail>) -> Void) {
        let values = ["id": id]
        Connection.send(endpoint: MoviesDetailAction.getMovieDetail, values: values as [String: AnyObject]) { (response) in
            switch response {
            case .success(let result):
                do {
                    let decoded = try JSONDecoder().decode(MovieDetail.self, from: result)
                    if decoded.overview.count > 0 {
                        completion(.success(result: decoded))
                    } else {
                        completion(.error(result: Error(code: "DM1001", message: "Invalid Data")))
                    }
                } catch {
                    completion(.error(result: Error.init(code: "DM1000", message: Errors.errorServer)))
                }
                break
            case .failure:
                completion(.error(result: Error.init(code: "DM2000", message: Errors.errorConnection)))
                break
            case .responseUnsuccessful(let code):
                if code == 412 {
                    completion(.error(result: Error.init(code: "DM4000", message: Errors.errorSecurity)))
                } else if code == -1009 {
                    completion(.error(result: Error.init(code: "DM3000", message: Errors.errorConnection)))
                } else {
                    completion(.error(result: Error.init(code: "DM1001", message: Errors.errorServer)))
                }
                
                break
            case .invalidData:
                completion(.error(result: Error.init(code: "DM1002", message: Errors.errorServer)))
                break
            }
        }
    }
}
