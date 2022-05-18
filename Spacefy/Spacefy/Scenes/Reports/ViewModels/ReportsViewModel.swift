//
//  ReportsViewModel.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 18/05/22.
//

import Foundation

class ReportsViewModel: BaseViewModelProtocol {
    
    var model: [ReportModel]?
    var title: String = "Reports"
    var progressHUDTitle: String = "Fetching Reports"
    
    func loadData(completion: @escaping (String?, Bool?) -> Void) {
        ReportsService.shared.fetchAll { (reports, error) in
            if let error = error {
                completion(error.localizedDescription, false)
                return
            }
            
            self.model = reports
            completion(nil, true)
        }
    }
    
}

