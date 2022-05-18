//
//  LaunchesViewModel.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 16/05/22.
//

import Foundation

protocol LaunchesViewModelProtocol {
    var launches: [LaunchModel]? { get set }
    var title: String { get }
    var progressHUDTitle: String { get }
    
    func loadData(completion: @escaping (String?, Bool?) -> Void)
}

class LaunchesViewModel: LaunchesViewModelProtocol {
    
    var launches: [LaunchModel]?
    var title: String = "Launches"
    var progressHUDTitle: String = "Fetching Launches"
    
    func loadData(completion: @escaping (String?, Bool?) -> Void) {
        LaunchesService.shared.fetchAll { (launches, error) in
            if let error = error {
                completion(error, nil)
                return
            }
            
            self.launches = launches?.results
            completion(nil, true)
        }
    }
    
}
