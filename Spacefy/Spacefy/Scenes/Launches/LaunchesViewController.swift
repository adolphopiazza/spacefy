//
//  LaunchesViewController.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 01/04/21.
//

import UIKit

class LaunchesViewController: SFYBaseViewController {

    static let launchesVCTitle = "Launches"
    private let tableView: UITableView = UITableView()
    private var launches: [LaunchModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = LaunchesViewController.launchesVCTitle
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

}

//MARK: - API Calls
extension LaunchesViewController {
    
    private func loadData() {
        progressHUD.textLabel.text = "Fetching Launches"
        progressHUD.show(in: view)
        LaunchesService.shared.fetchAll { (launches, error) in
            self.progressHUD.dismiss()
            if let error = error {
                self.showErrorAlertWith(message: error)
                return
            }
            
            self.emptyView.isHidden = true
            self.launches = launches?.results
            self.tableView.reloadData()
        }
    }
    
}

//MARK: - Layouts
extension LaunchesViewController {
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LaunchTableViewCell.self, forCellReuseIdentifier: LaunchTableViewCell.reuseID)
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
extension LaunchesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchTableViewCell.reuseID, for: indexPath) as? LaunchTableViewCell
        
        cell?.launch = launches?[indexPath.row]
        cell?.selectionStyle = .none
        
        return cell ?? UITableViewCell()
    }
    
}
