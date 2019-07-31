//
//  ConnectionResponse.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/30/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation

enum ConnectionResponse {
    case success(result: Data)
    case failure
    case responseUnsuccessful(code: Int)
    case invalidData
}
