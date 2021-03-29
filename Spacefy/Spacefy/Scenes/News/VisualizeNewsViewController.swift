//
//  VisualizeNewsViewController.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 19/03/21.
//

import UIKit

class VisualizeNewsViewController: SFYScrollViewController {

    private var news: NewsModel?
    private let closeButton: SFYButton = SFYButton(title: "Close")
    private let newsImageView: UIImageView = UIImageView()
    private let summaryLabel: SFYLabel = SFYLabel()
    private let dateLabel: SFYLabel = SFYLabel()
    private let readOnWebsiteButton: SFYButton = SFYButton()
    
    init(news: NewsModel?) {
        super.init(nibName: nil, bundle: nil)
        self.news = news
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImage()
    }

}

//MARK: - Actions
extension VisualizeNewsViewController {
    
    private func loadImage() {
        progressHUD.show(in: view)
        NewsService.shared.fetchImage(url: news?.imageUrl ?? "") { (image, error) in
            self.progressHUD.dismiss()
            if let error = error {
                print(error)
                return
            }
            
            self.setupLayouts()
            self.newsImageView.image = image
        }
    }
    
}

//MARK: - Layouts
extension VisualizeNewsViewController {
    
    private func setupLayouts() {
        setupNewsImageView()
        setupCloseButton()
        setupSummaryLabel()
        setupDateLabel()
        setupReadOnWebsiteButton()
    }
    
    private func setupCloseButton() {
        view.addSubview(closeButton)
        
        closeButton.configure(font: .systemFont(ofSize: 14, weight: .semibold))
        closeButton.onTap {
            self.dismiss(animated: true, completion: nil)
        }
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    private func setupNewsImageView() {
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(newsImageView)
        
        newsImageView.contentMode = .scaleToFill
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.3)
        ])
    }
    
    private func setupSummaryLabel() {
        contentView.addSubview(summaryLabel)
        summaryLabel.configure(text: news?.summary, font: .systemFont(ofSize: 22, weight: .semibold))
        summaryLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 20),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupDateLabel() {
        contentView.addSubview(dateLabel)
        dateLabel.configure(text: news?.publishedAt?.formatToBRLDate, color: .secondaryLabel, font: .systemFont(ofSize: 15))
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: summaryLabel.leadingAnchor)
        ])
    }
    
    private func setupReadOnWebsiteButton() {
        contentView.addSubview(readOnWebsiteButton)
        
        readOnWebsiteButton.setTitle("Read this on \(news?.newsSite ?? "Safari")", for: .normal)
        readOnWebsiteButton.configure(backgroundColor: .tertiarySystemFill)
        readOnWebsiteButton.onTap {
            guard let newsURL = self.news?.url, let url = URL(string: newsURL) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        NSLayoutConstraint.activate([
            readOnWebsiteButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            readOnWebsiteButton.leadingAnchor.constraint(equalTo: summaryLabel.leadingAnchor),
            readOnWebsiteButton.trailingAnchor.constraint(equalTo: summaryLabel.trailingAnchor),
            readOnWebsiteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            readOnWebsiteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
