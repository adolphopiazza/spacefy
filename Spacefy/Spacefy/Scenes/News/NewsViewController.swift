//
//  NewsViewController.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 07/03/21.
//

import UIKit
import JGProgressHUD

class NewsViewController: UIViewController {

    static let newsVCTitle = "Latest News"
    
    private let progressHUD: JGProgressHUD = JGProgressHUD(style: .dark)
    private let tableView: UITableView = UITableView()
    private var articles: [NewsModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTableView()
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
                print(error)
                return
            }
            
            self.articles = news
            self.tableView.reloadData()
        }
    }
    
}

//MARK: - Layouts
extension NewsViewController {
    
    private func setupView() {
        title = NewsViewController.newsVCTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    
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
    
}
