//
//  SFYScrollViewController.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 29/03/21.
//

import UIKit

class SFYScrollViewController: SFYBaseViewController {
    
    private let scrollView: UIScrollView = UIScrollView()
    let contentView: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollAndContentView()
    }

}

//MARK: - Layouts
extension SFYScrollViewController {
    
    private func setupScrollAndContentView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
}
