//
//  NewsService.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 07/03/21.
//

import Foundation
import Alamofire

class NewsService {
    
    static let shared = NewsService()
    
    init() {}
    
    func fetchAll(completionHandler: @escaping ([NewsModel]?, AFError?) -> Void) {
        let request = AF.request(SFYNetworking.articles)
        
        request.responseDecodable(of: [NewsModel].self) { (response) in
            if let error = response.error {
                completionHandler(nil, error)
                return
            }
            
            completionHandler(response.value, nil)
        }
    }
    
}
