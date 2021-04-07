//
//  NewsTableViewCell.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 15/03/21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let reuseID = "NewsTableViewCell"
    private let newsTitle: SFYLabel = SFYLabel()
    private let newsPublishedAt: SFYLabel = SFYLabel()
    private let newsSite: SFYLabel = SFYLabel()
    
    var news: NewsModel? {
        didSet {
            setupLayout()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Layouts
extension NewsTableViewCell {
    
    private func setupLayout() {
        selectionStyle = .none
        
        setupNewsTitle()
        setupNewsPublishedAt()
        setupNewsSite()
    }
    
    private func setupNewsTitle() {
        addSubview(newsTitle)
        newsTitle.configure(text: news?.title, font: .systemFont(ofSize: 22, weight: .semibold))
        
        NSLayoutConstraint.activate([
            newsTitle.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            newsTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            newsTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
    
    private func setupNewsPublishedAt() {
        addSubview(newsPublishedAt)
        newsPublishedAt.configure(text: news?.publishedAt?.formatToNewsDate, color: .secondaryLabel, font: .systemFont(ofSize: 15))
        
        NSLayoutConstraint.activate([
            newsPublishedAt.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 20),
            newsPublishedAt.leadingAnchor.constraint(equalTo: newsTitle.leadingAnchor),
            newsPublishedAt.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    private func setupNewsSite() {
        addSubview(newsSite)
        newsSite.configure(text: news?.newsSite, color: .secondaryLabel, font: .systemFont(ofSize: 15))
        
        NSLayoutConstraint.activate([
            newsSite.centerYAnchor.constraint(equalTo: newsPublishedAt.centerYAnchor),
            newsSite.trailingAnchor.constraint(equalTo: newsTitle.trailingAnchor)
        ])
    }
    
}
