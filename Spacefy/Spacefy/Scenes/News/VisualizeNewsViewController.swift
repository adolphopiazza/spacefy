//
//  VisualizeNewsViewController.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 19/03/21.
//

import UIKit
import JGProgressHUD

class VisualizeNewsViewController: UIViewController {

    private var news: NewsModel?
    private let progressHUD = JGProgressHUD(style: .dark)
    private let closeButton: UIButton = UIButton()
    private let newsImageView: UIImageView = UIImageView()
    private let summaryLabel: UILabel = UILabel()
    private let dateLabel: UILabel = UILabel()
    private let readOnWebsiteButton: UIButton = UIButton()
    private let scrollView: UIScrollView = UIScrollView()
    private let contentView: UIView = UIView()
    
    init(news: NewsModel?) {
        super.init(nibName: nil, bundle: nil)
        self.news = news
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        loadImage()
    }

}

//MARK: - Actions
extension VisualizeNewsViewController {
    
    @objc private func closeAction() {
        dismiss(animated: true, completion: nil)
    }
    
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
    
    @objc private func openWebsite() {
        guard let newsURL = news?.url, let url = URL(string: newsURL) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}

//MARK: - Layouts
extension VisualizeNewsViewController {
    
    private func setupLayouts() {
        setupNewsImageView()
        setupScrollAndContentView()
        setupCloseButton()
        setupSummaryLabel()
        setupDateLabel()
        setupReadOnWebsiteButton()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupCloseButton() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.label, for: .normal)
        closeButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        closeButton.backgroundColor = .systemBackground
        closeButton.layer.cornerRadius = 10
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    private func setupNewsImageView() {
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newsImageView)
        
        newsImageView.contentMode = .scaleToFill
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: view.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsImageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.3)
        ])
    }
    
    private func setupScrollAndContentView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: newsImageView.bottomAnchor),
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
    
    private func setupSummaryLabel() {
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(summaryLabel)
        
        summaryLabel.text = news?.summary
        summaryLabel.textColor = .label
        summaryLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        summaryLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        
        dateLabel.text = news?.publishedAt?.formatToBRLDate
        dateLabel.textColor = .secondaryLabel
        dateLabel.font = .systemFont(ofSize: 15)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: summaryLabel.leadingAnchor)
        ])
    }
    
    private func setupReadOnWebsiteButton() {
        readOnWebsiteButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(readOnWebsiteButton)
        
        readOnWebsiteButton.setTitle("Read this on \(news?.newsSite ?? "Safari")", for: .normal)
        readOnWebsiteButton.setTitleColor(.label, for: .normal)
        readOnWebsiteButton.backgroundColor = .tertiarySystemFill
        readOnWebsiteButton.layer.cornerRadius = 10
        readOnWebsiteButton.addTarget(self, action: #selector(openWebsite), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            readOnWebsiteButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            readOnWebsiteButton.leadingAnchor.constraint(equalTo: summaryLabel.leadingAnchor),
            readOnWebsiteButton.trailingAnchor.constraint(equalTo: summaryLabel.trailingAnchor),
            readOnWebsiteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            readOnWebsiteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
