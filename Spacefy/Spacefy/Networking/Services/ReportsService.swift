//
//  ReportsService.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 29/03/21.
//

import Foundation
import Alamofire

class ReportsService {
    
    static let shared = ReportsService()
    
    init() {}
    
    func fetchAll(completionHandler: @escaping ([ReportModel]?, AFError?) -> Void) {
        let request = AF.request(SFYNetworking.reports)
        
        request.responseDecodable(of: [ReportModel].self) { (response) in
            if let error = response.error {
                completionHandler(nil, error)
                return
            }
            
            completionHandler(response.value, nil)
        }
    }
    
    func fetchImage(url: String, completionHandler: @escaping (UIImage?, AFError?) -> Void) {
        let request = AF.request(url)
        
        request.responseData { (response) in
            if let error = response.error {
                completionHandler(nil, error)
                return
            }
            
            if let data = response.data {
                completionHandler(UIImage(data: data), nil)
            }
        }
    }
    
}
