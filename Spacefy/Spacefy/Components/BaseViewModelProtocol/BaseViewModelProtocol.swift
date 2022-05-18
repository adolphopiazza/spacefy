//
//  BaseViewModelProtocol.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 18/05/22.
//

import Foundation

protocol BaseViewModelProtocol {
    associatedtype Model
    var model: [Model]? { get set }
    var title: String { get }
    var progressHUDTitle: String { get }
    
    func loadData(completion: @escaping (String?, Bool?) -> Void)
}
