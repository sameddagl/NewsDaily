//
//  FavoritesCoordinator.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 4.01.2023.
//

import UIKit

protocol FavoritesCoordinatorProtocol: Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
    func goToDetail(article: Article)
}

final class FavoritesCoordinator: FavoritesCoordinatorProtocol {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = FavoritesViewController()
        let viewModel = FavoritesViewModel(coreDataManager: AppContainer.coreDataManager, coordinator: self)
        
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
