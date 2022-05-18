//
//  LaunchTableViewCell.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 05/04/21.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {

    static let reuseID = "LaunchTableViewCell"
    private let titleLabel: SFYLabel = SFYLabel()
    private let netLabel: SFYLabel = SFYLabel()
    private let missionName: SFYLabel = SFYLabel()
    private let orbitName: SFYLabel = SFYLabel()
    private let padName: SFYLabel = SFYLabel()
    
    var launch: LaunchModel? {
        didSet {
            titleLabel.configure(text: launch?.name, font: .systemFont(ofSize: 24, weight: .semibold))
            netLabel.configure(text: launch?.net.formatTo(date: .launchesFormat), font: .systemFont(ofSize: 20))
            missionName.configure(text: launch?.mission?.name, color: .secondaryLabel, font: .systemFont(ofSize: 14))
            orbitName.configure(text: launch?.mission?.orbit?.name, color: .secondaryLabel, font: .systemFont(ofSize: 14))
            padName.configure(text: launch?.pad.name, color: .secondaryLabel, font: .systemFont(ofSize: 14))
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstants()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Layouts
extension LaunchTableViewCell {
    
    private func setupView() {
        let labels: [SFYLabel] = [titleLabel, netLabel, missionName, orbitName, padName]
        labels.forEach({ addSubview($0) })
        titleLabel.textAlignment = .center
    }
    
    private func setupConstants() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            netLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            netLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            missionName.topAnchor.constraint(equalTo: netLabel.bottomAnchor, constant: 20),
            missionName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            orbitName.topAnchor.constraint(equalTo: netLabel.bottomAnchor, constant: 20),
            orbitName.leadingAnchor.constraint(greaterThanOrEqualTo: missionName.trailingAnchor, constant: 2),
            orbitName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            padName.topAnchor.constraint(equalTo: missionName.bottomAnchor, constant: 5),
            padName.leadingAnchor.constraint(equalTo: missionName.leadingAnchor),
            padName.trailingAnchor.constraint(equalTo: orbitName.trailingAnchor),
            padName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    
}
