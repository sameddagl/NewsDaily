//
//  HomeViewController.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import UIKit

class HomeViewController: UIViewController {
    var viewModel: HomeViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "news_title".localized(with: "")
        view.backgroundColor = .systemBackground
        viewModel.load()
    }

}

extension HomeViewController: HomeViewDelegate {
    func handleOutputs(_ output: HomeViewModelOutput) {
        switch output {
        case .startLoading:
            print("loading")
        case .endLoading:
            print("endLoading")
        case .didUploadWithNews(let news):
            print(news.count)
        case .pagination:
            break
        case .refreshNews:
            break
        case .didFailWithError(let title, let message):
            print(title, message)
        }
    }
    
    func navigate(to route: HomeViewModelRoute) {
        
    }
}
