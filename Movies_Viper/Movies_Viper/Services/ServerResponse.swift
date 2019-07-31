//
//  ServerResponse.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/30/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation

struct ServerResponse<T: Decodable>: Decodable {
    let status: Bool
    var results: T?
    let error: Error?
}

struct Error: Decodable {
    let code: String
    let message: String
    let description: String?
    
    init(code: String, message: String) {
        self.code = code
        self.message = message
        self.description = ""
    }
}
/*
struct Error: Decodable {
    let code: String
    let message: String
    let description: String?
    
    init(code: String, message: String) {
        self.code = code
        self.message = message
        self.description = ""
    }
}
*/
