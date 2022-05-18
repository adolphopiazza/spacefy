//
//  NewsViewController.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 07/03/21.
//

import UIKit

class NewsViewController: SFYBaseViewController {
    
    private let tableView: UITableView = UITableView()
    private let viewModel: NewsViewModel
    
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title
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
        progressHUD.textLabel.text = viewModel.progressHUDTitle
        progressHUD.show(in: view)
        viewModel.loadData { error, _ in
            self.progressHUD.dismiss()
            if let error = error {
                self.showErrorAlertWith(message: error)
                return
            }
            
            self.emptyView.isHidden = true
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
        return viewModel.model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        cell.news = viewModel.model?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = VisualizeNewsViewModel(news: viewModel.model?[indexPath.row])
        let visualizeVC = VisualizeNewsViewController(viewModel: viewModel)
        present(visualizeVC, animated: true, completion: nil)
    }
    
}
