//
//  LaunchesViewModel.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 16/05/22.
//

import Foundation

class LaunchesViewModel: BaseViewModelProtocol {
    
    var model: [LaunchModel]?
    var title: String = "Launches"
    var progressHUDTitle: String = "Fetching Launches"
    
    func loadData(completion: @escaping (String?, Bool?) -> Void) {
        LaunchesService.shared.fetchAll { (launches, error) in
            if let error = error {
                completion(error, nil)
                return
            }
            
            self.model = launches?.results
            completion(nil, true)
        }
    }
    
}
