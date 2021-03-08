//
//  NewsViewController.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 07/03/21.
//

import UIKit

class NewsViewController: UIViewController {

    static let newsVCTitle = "Latest News"
    
    private let tableView: UITableView = UITableView()
    private let testingNews: [String] = ["SpaceX launches falcon five", "NASA lands on Mars", "Men conquer the moon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTableView()
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
        return testingNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.textLabel?.text = testingNews[indexPath.row]
        
        return cell
    }
    
}
