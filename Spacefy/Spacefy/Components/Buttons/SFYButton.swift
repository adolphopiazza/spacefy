//
//  SFYButton.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 29/03/21.
//

import UIKit

class SFYButton: UIButton {

    var action: (() -> ())?
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setupButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Actions
extension SFYButton {
    
    @objc private func buttonAction() {
        if let action = action { action() }
    }
    
    func onTap(action: @escaping () -> ()) {
        self.action = action
    }
    
}

//MARK: - Layouts
extension SFYButton {
    
    private func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        layer.cornerRadius = 10
    }
    
    func configure(color: UIColor = .label, font: UIFont? = nil, backgroundColor: UIColor = .systemBackground) {
        setTitleColor(color, for: .normal)
        titleLabel?.font = font
        self.backgroundColor = backgroundColor
    }
    
}
