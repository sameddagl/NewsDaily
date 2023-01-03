//
//  SearchCoordinator.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 19.12.2022.
//

import UIKit

final class SearchCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SearchViewController()
        let viewModel = SearchViewModel(newsService: ServiceContainer.newsService, coordinator: self)
        
        viewModel.delegate = vc
        vc.viewModel = viewModel
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToDetail(article: Article) {
        let vc = DetailViewController()
        let viewModel = DetailViewModel(article: article, coreDataManager: AppContainer.coreDataManager)
        
        viewModel.delegate = vc
        vc.viewModel = viewModel
        
        navigationController.pushViewController(vc, animated: true)
    }

}
