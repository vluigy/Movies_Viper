//
//  ModelResponse.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/30/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation

enum ModelResponse<T> {
    case success(result: T)
    case error(result: Error)
}

