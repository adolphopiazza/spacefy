//
//  ReportModel.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 29/03/21.
//

import Foundation

struct ReportModel: Codable {
    
    let id: String
    let title: String?
    let url: String?
    let imageUrl: String?
    let newsSite: String?
    let summary: String?
    let publishedAt: String?
    
}
