//
//  LaunchesModel.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 01/04/21.
//

import Foundation

struct LaunchesModel: Codable {
    
    let count: Int
    let next: String
    let previous: String?
    let results: [LaunchModel]
    
}
