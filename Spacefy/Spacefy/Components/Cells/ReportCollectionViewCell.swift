//
//  ReportCollectionViewCell.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 29/03/21.
//

import UIKit

class ReportCollectionViewCell: UICollectionViewCell {
 
    static let identifier = "CollectionViewCell"
    
    private let scrollView: UIScrollView = UIScrollView()
    private let containerView: UIView = UIView()
    private let reportTitle: SFYLabel = SFYLabel()
    private let reportDate: SFYLabel = SFYLabel()
    private let reportSummary: SFYLabel = SFYLabel()
    private let readOnWebsiteButton: SFYButton = SFYButton()
    
    var report: ReportModel? {
        didSet {
            reportTitle.configure(text: report?.title, font: .systemFont(ofSize: 25, weight: .semibold))
            reportDate.configure(text: report?.publishedAt?.formatTo(date: .newsFormat), color: .secondaryLabel, font: .systemFont(ofSize: 15))
            reportSummary.configure(text: report?.summary, font: .systemFont(ofSize: 18))
            readOnWebsiteButton.setTitle("Continue reading on \(report?.newsSite ?? "Safari")", for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Layouts
extension ReportCollectionViewCell {
    
    private func setupLayout() {
        backgroundColor = .clear
        
        setupScrollView()
        setupContainerView()
        setupReportTitle()
        setupReportDate()
        setupReportSummary()
        setupReadOnWebsiteButton()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        
        scrollView.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerView)
        
        containerView.backgroundColor = .secondarySystemBackground
        containerView.layer.cornerRadius = 20

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupReportTitle() {
        containerView.addSubview(reportTitle)
        
        reportTitle.textAlignment = .center
        
        NSLayoutConstraint.activate([
            reportTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            reportTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            reportTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15)
        ])
    }
    
    private func setupReportDate() {
        containerView.addSubview(reportDate)
        
        NSLayoutConstraint.activate([
            reportDate.topAnchor.constraint(equalTo: reportTitle.bottomAnchor, constant: 25),
            reportDate.leadingAnchor.constraint(equalTo: reportTitle.leadingAnchor)
        ])
    }
    
    private func setupReportSummary() {
        containerView.addSubview(reportSummary)
        
        NSLayoutConstraint.activate([
            reportSummary.topAnchor.constraint(equalTo: reportDate.bottomAnchor, constant: 25),
            reportSummary.leadingAnchor.constraint(equalTo: reportDate.leadingAnchor),
            reportSummary.trailingAnchor.constraint(equalTo: reportTitle.trailingAnchor)
        ])
    }
    
    private func setupReadOnWebsiteButton() {
        containerView.addSubview(readOnWebsiteButton)
        
        readOnWebsiteButton.configure(backgroundColor: .tertiarySystemFill)
        readOnWebsiteButton.onTap {
            guard let newsURL = self.report?.url, let url = URL(string: newsURL) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        NSLayoutConstraint.activate([
            readOnWebsiteButton.topAnchor.constraint(equalTo: reportSummary.bottomAnchor, constant: 25),
            readOnWebsiteButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            readOnWebsiteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            readOnWebsiteButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
            readOnWebsiteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
