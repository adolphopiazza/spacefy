//
//  NewsViewModel.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 18/05/22.
//

import Foundation

class NewsViewModel: BaseViewModelProtocol {
    
    var model: [NewsModel]?
    var title: String = "Latest News"
    var progressHUDTitle: String = "Fetching News"
    
    func loadData(completion: @escaping (String?, Bool?) -> Void) {
        NewsService.shared.fetchAll { (news, error) in
            if let error = error {
                completion(error.localizedDescription, false)
                return
            }
            
            self.model = news
            completion(nil, true)
        }
    }
    
}
