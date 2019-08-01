//
//  MovieCrewModel.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 7/31/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import Foundation

struct MovieCrew: Codable {
    let name: String
    let job: String
    
    private enum CodingKeys: CodingKey {
        case name
        case job
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.job = try container.decode(String.self, forKey: .job)
    }
    
    init(name: String, job:String) {
        self.name = name
        self.job = job
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(job, forKey: .job)
    }
}
