//
//  MovieListInteractor.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/30/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation
import Alamofire


enum MoviesAction {
    case getMoviesList
}

extension MoviesAction: Endpoint {
    var base: String {
        return apiDomain
    }
    var path: String {
        switch self {
        case .getMoviesList: return "discover/movie?\(apiKey)"
        }
    }
}


class NoticeInteractor: PresenterToInteractorProtocol{
    var presenter: InteractorToPresenterProtocol?

    func getList(){
        self.getMoviesRequest() { [weak self] response in
            guard let _ = self else {return}
            switch response {
            case .success(let result):
                self?.presenter?.moviesFetchedSuccess(moviesModelArray: result.results)
                break
            case .error(_):
                self?.presenter?.noticeFetchFailed()
                break
            }
        }
    }
    
    func getMoviesRequest(completion: @escaping (_ response: ModelResponse<MoviesData>) -> Void) {
        Connection.send(endpoint: MoviesAction.getMoviesList, values: [:] as [String: AnyObject]) { (response) in
            switch response {
            case .success(let result):
                do {
                    let decoded = try JSONDecoder().decode(MoviesData.self, from: result)
                    if decoded.results.count > 0 {
                        completion(.success(result: decoded))
                    } else {
                        completion(.error(result: Error(code: "1001", message: "Invalid Data")))
                    }
                } catch {
                    completion(.error(result: Error.init(code: "GM1000", message: Errors.errorServer)))
                }
                break
            case .failure:
                completion(.error(result: Error.init(code: "GM2000", message: Errors.errorConnection)))
                break
            case .responseUnsuccessful(let code):
                if code == 412 {
                    completion(.error(result: Error.init(code: "GM4000", message: Errors.errorSecurity)))
                } else if code == -1009 {
                    completion(.error(result: Error.init(code: "GM3000", message: Errors.errorConnection)))
                } else {
                    completion(.error(result: Error.init(code: "GM1001", message: Errors.errorServer)))
                }
                
                break
            case .invalidData:
                completion(.error(result: Error.init(code: "GM1002", message: Errors.errorServer)))
                break
            }
        }
    }
    
}
