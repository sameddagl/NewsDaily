//
//  FavoritesViewController.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "favorites_title".localized(with: "")
        view.backgroundColor = .systemBackground
        
        let savedArticles = AppContainer.coreDataManager.fetchSavedNews()
        savedArticles.forEach { print($0.title) }
    }
}

//MARK: - UI Related
extension FavoritesViewController {
    private func layout() {
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
}

