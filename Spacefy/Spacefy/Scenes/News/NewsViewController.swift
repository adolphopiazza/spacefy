//
//  NewsViewController.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 07/03/21.
//

import UIKit

class NewsViewController: SFYBaseViewController {

    static let newsVCTitle = "Latest News"
    
    private let tableView: UITableView = UITableView()
    private var articles: [NewsModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NewsViewController.newsVCTitle
        isLargeTitle = true
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

}

//MARK: - API Calls
extension NewsViewController {
    
    private func loadData() {
        progressHUD.textLabel.text = "Fetching News"
        progressHUD.show(in: view)
        
        NewsService.shared.fetchAll { (news, error) in
            self.progressHUD.dismiss()
            if let error = error {
                self.showErrorAlertWith(message: error.localizedDescription)
                return
            }
            
            self.emptyView.isHidden = true
            self.articles = news
            self.tableView.reloadData()
        }
    }
    
}

//MARK: - Layouts
extension NewsViewController {
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

//MARK: - TableView Delegates
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        cell.news = articles?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let visualizeVC = VisualizeNewsViewController(news: articles?[indexPath.row])
        present(visualizeVC, animated: true, completion: nil)
    }
    
}
