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
    
    func fetchAll(completionHandler: @escaping (LaunchesModel?, String?) -> Void) {
        let request = AF.request(SFYNetworking.upcomingLaunches)
        
        request.response { (response) in
            if let error = response.error {
                completionHandler(nil, error.localizedDescription)
                return
            }
            
            guard let data = response.data, response.response?.statusCode == 200 else {
                do {
                    let decoder = JSONDecoder()
                    let detail = try decoder.decode([String: String].self, from: response.data ?? Data())
                    completionHandler(nil, detail.values.first)
                } catch let err {
                    completionHandler(nil, err.localizedDescription)
                    print(err)
                }
                
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let launches = try decoder.decode(LaunchesModel.self, from: data)
                completionHandler(launches, nil)
            } catch let err {
                completionHandler(nil, err.localizedDescription)
                print(err)
            }
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
