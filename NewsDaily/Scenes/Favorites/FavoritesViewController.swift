//
//  FavoritesViewController.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    //MARK: - UI Properties
    private var collectionView: UICollectionView!
    
    //MARK: - Injections
    var viewModel: FavoritesViewModelProtocol!
    
    //MARK: - Properties
    private var savedArticles = [ArticlePresentation]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.load()
        collectionView.reloadData()
    }
    
    //MARK: - Actions
    @objc private func deleteAllTapped() {
        viewModel.deleteAllTapped()
    }
    
    private func showDeleteAllAlert() {
        let ac = UIAlertController(title: "delete_all_title".localized(), message: "delete_all_message".localized(), preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "yes".localized(), style: .destructive) { [weak self] _ in
            self?.viewModel.deleteAll()
        }
        
        let cancelAction = UIAlertAction(title: "cancel".localized(), style: .cancel)
        
        ac.addAction(okayAction)
        ac.addAction(cancelAction)
        
        present(ac, animated: true)
    }
}

//MARK: - View Model Outputs
extension FavoritesViewController: FavoritesViewDelegate {
    func handleOutput(_ output: FavoritesOutput) {
        switch output {
        case .didUploadWithNews(let news):
            self.savedArticles = news
            collectionView.reloadData()
        case .isDeleteAllEnabled(let isEnabled):
            navigationItem.rightBarButtonItem?.isEnabled = isEnabled
        case .emptyState(let message):
            showEmptyStateView(with: message, in: self.view)
        case .removeEmptyState:
            removeEmptyStateView()
        case .showAlert:
            showDeleteAllAlert()
        case .didFailWithError(let title, let message):
            print(title, message)
        }
    }
}

//MARK: - Collection View Delegates
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        let article = savedArticles[indexPath.item]
        cell.set(article: article)
        return cell
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectItem(at: indexPath.item)
    }
}

//MARK: - UI Related
extension FavoritesViewController {
    private func layout() {
        configureView()
        configureCollectionView()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "favorites_title".localized(with: "")
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAllTapped))
        navigationItem.rightBarButtonItem = trashButton
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: create2ColumnLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.reuseID)
        view.addSubview(collectionView)
    }
    
    private func create2ColumnLayout() -> UICollectionViewFlowLayout {
        let width = view.frame.width
        let padding: CGFloat = 10
        let itemSpacing: CGFloat = 10
        
        let availableWidth = width - (padding * 2) - (itemSpacing)
        let itemWidth = availableWidth / 2
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = .init(width: itemWidth, height: itemWidth + 50)
        return layout
    }
}

