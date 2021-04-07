//
//  PadModel.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 01/04/21.
//

import Foundation

struct PadModel: Codable {
    
    let id: Int
    let url: String
    let agencyId: Int?
    let longitude: String
    let latitude: String
    let name: String
    let infoUrl: String?
    let wikiUrl: String
    let mapUrl: String
    let location: Location
    let mapImage: String
    let totalLaunchCount: Int
    
}

struct Location: Codable {
    
    let id: Int
    let url: String
    let name: String
    let countryCode: String
    let mapImage: String
    
}
