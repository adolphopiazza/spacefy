//
//  NewsModel.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 07/03/21.
//

import Foundation

struct NewsModel: Codable {
    
    let id: String
    let featured: Bool?
    let title: String?
    let url: String?
    let imageUrl: String?
    let newsSite: String?
    let summary: String?
    let publishedAt: String?
    
}
