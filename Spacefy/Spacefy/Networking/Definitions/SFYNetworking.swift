//
//  SFYNetworking.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 07/03/21.
//

import Foundation

enum SFYNetworking {
    
    static let SFNBaseURL = "https://spaceflightnewsapi.net/api/v2/"
    static let articles = SFNBaseURL + "articles"
    static let reports = SFNBaseURL + "reports"
    
    static let TSDBaseURL = "https://ll.thespacedevs.com/2.0.0/"
    static let launches = TSDBaseURL + "launch"
    static let upcomingLaunches = TSDBaseURL + "launch/upcoming"
    
}
