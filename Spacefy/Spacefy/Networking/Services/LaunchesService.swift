//
//  LaunchesService.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 01/04/21.
//

import Foundation
import Alamofire

class LaunchesService {
    
    static let shared = LaunchesService()
    
    init() {}
    
    func fetchAll(completionHandler: @escaping (LaunchesModel?, Error?) -> Void) {
        let request = AF.request(SFYNetworking.upcomingLaunches)
        
        request.response { (response) in
            if let error = response.error {
                completionHandler(nil, error)
                return
            }
            
            guard let data = response.data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let launches = try decoder.decode(LaunchesModel.self, from: data)
                completionHandler(launches, nil)
            } catch let err {
                completionHandler(nil, err)
                print(err)
            }
        }
    }
    
//    func fetchImage(url: String, completionHandler: @escaping (UIImage?, AFError?) -> Void) {
//        let request = AF.request(url)
//
//        request.responseData { (response) in
//            if let error = response.error {
//                completionHandler(nil, error)
//                return
//            }
//
//            if let data = response.data {
//                completionHandler(UIImage(data: data), nil)
//            }
//        }
//    }
    
}
