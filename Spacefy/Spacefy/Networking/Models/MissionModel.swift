//
//  MissionModel.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 01/04/21.
//

import Foundation

struct MissionModel: Codable {
    
    let id: Int
    let launchLibraryId: Int?
    let name: String
    let description: String
    let type: String
    let orbit: Orbit?
    
}

struct Orbit: Codable {
    
    let id: Int
    let name: String
    let abbrev: String
    
}
