//
//  MovieDetailInteractor.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/30/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation
import Alamofire

enum MoviesDetailAction {
    case getMovieDetail(id: Int)
}

extension MoviesDetailAction: Endpoint {
    
    var base: String {
        return apiDomain
    }
    var path: String {
        switch self {
        case .getMovieDetail(let id):
            return "movie/\(id)?\(apiKey)&append_to_response=credits"
        }
    }
}

class MovieInteractor:PresenterToInteractorMovieProtocol{
    var presenter: InteractorToPresenterMovieProtocol?
    
    func getDetail(id:Int){
        self.getDetailRequest(id: id) { [weak self] response in
            
            guard let _ = self else {return}
            switch response {
            case .success(let result):
                self?.presenter?.movieFetchSuccess(movieDetailInteractor: result)
                UserDefaultsUtils.saveMovieDetail(movies: [result])
                break
            case .error(let result):
                let localDetail = UserDefaultsUtils.getMovieDetail().filter({$0.id == id})
                if localDetail.count > 0{
                    self?.presenter?.movieFetchSuccess(movieDetailInteractor: localDetail[0])
                }else{
                    self?.presenter?.movieFetchFailed(error: result.message + " " + result.code)
                }
                break
            }
        }
    }
    
    func getDetailRequest(id:Int, completion: @escaping (_ response: ModelResponse<MovieDetail>) -> Void) {
        Connection.send(endpoint: MoviesDetailAction.getMovieDetail(id: id), values: [:]) { (response) in
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
