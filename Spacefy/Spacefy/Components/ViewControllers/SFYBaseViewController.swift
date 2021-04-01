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
    
    func showOKAlertWith(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlertWith(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
