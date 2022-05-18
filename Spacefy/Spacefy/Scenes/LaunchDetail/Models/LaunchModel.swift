//
//  LaunchModel.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 01/04/21.
//

import Foundation

struct LaunchModel: Codable {
    
    let id: String
    let url: String
    let name: String
    let net: String
    let launchServiceProvider: LaunchProviderModel
    let rocket: RocketModel
    let mission: MissionModel?
    let pad: PadModel
    let webcastLive: Bool
    let image: String
    
}
