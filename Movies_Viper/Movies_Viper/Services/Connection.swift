//
//  Connection.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/30/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class Connection {
    static var DOMAIN: String?
    
    static func send(endpoint: Endpoint, values: [String: Any]?, completion: @escaping (ConnectionResponse) -> Void) {
        let url = URL(string: "\(endpoint.base)\(endpoint.path)")
        guard let cookies = HTTPCookieStorage.shared.cookies else {return}
        var cookiesHeader = ""
        for cookie:HTTPCookie in cookies {
            cookiesHeader += "\(cookie.name)=\(cookie.value); "
        }
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Cookie": cookiesHeader
        ]
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        request.timeoutInterval = 15
        request.cachePolicy = .useProtocolCachePolicy
        //request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        Alamofire.request(request)
            .responseJSON { (response) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if response.response != nil {
                    if response.error == nil{
                        let httpResponse = response.response
                        if httpResponse!.statusCode == 200 {
                            if response.data!.count > 0 {
                                completion(.success(result: response.data!))
                            } else {
                                completion(.invalidData)
                            }
                        } else {
                            completion(.responseUnsuccessful(code: httpResponse!.statusCode))
                        }
                    }
                }else{
                    _ = response.result
                    completion(.responseUnsuccessful(code: -1009))
                }
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    static func urlEncode(params: [String: AnyObject]) -> String {
        let customAllowedSet = NSCharacterSet(charactersIn: "!*'();:@&=+$,/?%#[]").inverted
        var pairs: [String] = []
        for (key, value) in params {
            if value is Dictionary<String, AnyObject> {
                for (subKey, subValue) in value as! Dictionary<String, AnyObject> {
                    let string: String = "\(subValue)"
                    let escaped_value = string.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
                    pairs.append("\(key)[\(subKey)]=\(escaped_value!)")
                }
                
            } else if value is Array<AnyObject> {
                var i = 0
                for subValue in value as! Array<AnyObject> {
                    if subValue is Dictionary<String, AnyObject> {
                        for (subKey, subSubValue) in subValue as! Dictionary<String, AnyObject> {
                            let string: String = "\(subSubValue)"
                            let escaped_value = string.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
                            pairs.append("\(key)[\(i)][\(subKey)]=\(escaped_value!)")
                        }
                    } else {
                        let string: String = "\(subValue)"
                        let escaped_value = string.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
                        pairs.append("\(key)[]=\(escaped_value!)")
                    }
                    i += 1
                }
            } else {
                let string = "\(value)"
                let escaped_value = string.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
                pairs.append("\(key)=\(escaped_value!)")
            }
        }
        return pairs.joined(separator: "&")
    }
    
    static func clearCookies() {
        let cookieStorage = HTTPCookieStorage.shared
        
        guard let cookies = cookieStorage.cookies else { return }
        
        for cookie in cookies {
            cookieStorage.deleteCookie(cookie)
        }
    }
}
