//
//  SFYLabel.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 29/03/21.
//

import UIKit

class SFYLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Layouts
extension SFYLabel {
    
    func configure(text: String?, color: UIColor = .label, font: UIFont) {
        self.text = text
        self.textColor = color
        self.font = font
    }
    
}
