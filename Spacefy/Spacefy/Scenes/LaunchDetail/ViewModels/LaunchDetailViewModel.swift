//
//  LaunchDetailViewModel.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 18/05/22.
//

import Foundation

protocol LaunchDetailViewModelProtocol {
    var launch: LaunchModel? { get set }
    var countdownLabel: String { get }
}

class LaunchDetailViewModel: LaunchDetailViewModelProtocol {
    
    var launch: LaunchModel?
    var countdownLabel: String = "ETA"
    
    init(launch: LaunchModel?) {
        self.launch = launch
    }
    
}
