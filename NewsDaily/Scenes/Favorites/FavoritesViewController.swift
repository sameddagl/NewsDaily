//
//  FavoritesViewController.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    private var collectionView: UICollectionView!
    
    private var savedArticles = [NewsModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        
        savedArticles = AppContainer.coreDataManager.fetchSavedNews()
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        let article = savedArticles[indexPath.row]
        cell.set(article: ArticlePresentation(article: article))
        return cell
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
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: create2ColumnLayout())
        collectionView.dataSource = self
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

