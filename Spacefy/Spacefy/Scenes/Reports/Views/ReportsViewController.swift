//
//  ReportsViewController.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 29/03/21.
//

import UIKit

class ReportsViewController: SFYBaseViewController {

    private var collectionView: UICollectionView?
    private let pageControl: UIPageControl = UIPageControl()
    private let viewModel: ReportsViewModel
    
    init(viewModel: ReportsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        navigationController?.navigationBar.isHidden = true
        
        setupPageControl()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

}

//MARK: - API Calls
extension ReportsViewController {
    
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
            self.pageControl.numberOfPages = self.viewModel.model?.count ?? 0
            self.collectionView?.reloadData()
        }
    }
    
}

//MARK: - Layouts
extension ReportsViewController {
    
    private func setupPageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        
        pageControl.currentPageIndicatorTintColor = .systemGray
        pageControl.pageIndicatorTintColor = .systemGray3
        pageControl.isUserInteractionEnabled = false
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    private func setupCollectionView() {
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: cvLayout)
        collectionView?.register(ReportCollectionViewCell.self, forCellWithReuseIdentifier: ReportCollectionViewCell.identifier)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        
        collectionView?.backgroundColor = .clear
        layCollectionView()
    }
    
    private func layCollectionView() {
        guard let collectionView = collectionView else { return }
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -15),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
}

//MARK: - CollectionView Delegates
extension ReportsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.model?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReportCollectionViewCell.identifier, for: indexPath)
                as? ReportCollectionViewCell else { return UICollectionViewCell() }
        
        cell.report = viewModel.model?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.7)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let collectionView = scrollView as? UICollectionView, collectionView == self.collectionView {
            let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            pageControl.currentPage = Int(pageNumber)
        }
    }
    
}
