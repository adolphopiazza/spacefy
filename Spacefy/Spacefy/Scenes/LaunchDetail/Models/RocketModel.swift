//
//  RocketModel.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 01/04/21.
//

import Foundation

struct RocketModel: Codable {
    
    let id: Int
    let configuration: RocketConfiguration
    
}

struct RocketConfiguration: Codable {
    
    let id: Int
    let launchLibraryId: Int
    let url: String
    let name: String
    let family: String
    let fullName: String
    let variant: String
    
}
