//
//  SFYBaseViewController.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 29/03/21.
//

import UIKit
import JGProgressHUD

class SFYBaseViewController: UIViewController {

    let progressHUD: JGProgressHUD = JGProgressHUD(style: .dark)
    
    var isLargeTitle: Bool? {
        didSet {
            navigationController?.navigationBar.prefersLargeTitles = isLargeTitle ?? false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

}

//MARK: - Layouts
extension SFYBaseViewController {
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
}
