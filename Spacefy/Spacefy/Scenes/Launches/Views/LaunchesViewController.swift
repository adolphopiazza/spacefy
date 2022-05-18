//
//  LaunchesViewController.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 01/04/21.
//

import UIKit

class LaunchesViewController: SFYBaseViewController {

    private let tableView: UITableView = UITableView()
    private let viewModel: LaunchesViewModel
    
    init(viewModel: LaunchesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
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
        progressHUD.textLabel.text = viewModel.progressHUDTitle
        progressHUD.show(in: view)
        viewModel.loadData { error, _ in
            self.progressHUD.dismiss()
            if let error = error {
                self.showErrorAlertWith(message: error)
                return
            }
            
            self.tableView.reloadData()
            self.emptyView.isHidden = true
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
        return viewModel.launches?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchTableViewCell.reuseID, for: indexPath) as? LaunchTableViewCell
        
        cell?.launch = viewModel.launches?[indexPath.row]
        cell?.selectionStyle = .none
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let launchDetailVC = LaunchDetailViewController()

        launchDetailVC.launch = viewModel.launches?[indexPath.row]
        launchDetailVC.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(launchDetailVC, animated: true)
    }
    
}
