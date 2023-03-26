//
//  HomeCoordinator.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 19.12.2022.
//

import UIKit

protocol HomeCoordinatorProtocol: Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
    func goToDetail(article: Article)
    func goToSort(delegate: HomeViewModel)
}

final class HomeCoordinator: HomeCoordinatorProtocol {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeViewController()
        let viewModel = HomeViewModel(newsService: ServiceContainer.newsService, coordinator: self)
        
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
    
    func goToSort(delegate: HomeViewModel) {
        let vc = SortViewController()
        vc.delegate = delegate
        navigationController.present(UINavigationController(rootViewController: vc), animated: true)
    }
}
