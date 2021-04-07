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
    let emptyView: UIView = UIView()
    
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
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive) { action in
            self.setupEmptyView()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func setupEmptyView() {
        let label: SFYLabel = SFYLabel()
        let image: UIImageView = UIImageView()
        
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(emptyView)
        emptyView.addSubview(label)
        emptyView.addSubview(image)
        
        label.configure(text: "Something went wrong 😔", font: .systemFont(ofSize: 22, weight: .semibold))
        image.image = UIImage.SFYBaseVC.error
        image.tintColor = .label
        
        NSLayoutConstraint.activate([
            emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            image.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 10),
            image.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 40),
            image.heightAnchor.constraint(equalToConstant: 40),
            
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: emptyView.bottomAnchor)
        ])
    }
    
}
