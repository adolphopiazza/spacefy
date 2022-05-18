//
//  VisualizeNewsViewModel.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 18/05/22.
//

import UIKit

protocol VisualizeNewsViewModelProtocol {
    var news: NewsModel? { get set }
    
    func loadImage(completion: @escaping (UIImage?, String?) -> Void)
    func getButtonTitle() -> String?
}

class VisualizeNewsViewModel: VisualizeNewsViewModelProtocol {
    
    var news: NewsModel?
    
    init(news: NewsModel?) {
        self.news = news
    }
    
    func loadImage(completion: @escaping (UIImage?, String?) -> Void) {
        NewsService.shared.fetchImage(url: news?.imageUrl ?? "") { (image, error) in
            if let error = error {
                completion(nil, error.localizedDescription)
                return
            }
            
            completion(image, nil)
        }
    }
    
    func getButtonTitle() -> String? {
        "Read this on \(news?.newsSite ?? "Safari")"
    }
}
