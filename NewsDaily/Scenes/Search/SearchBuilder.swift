//
//  SearchBuilder.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 13.12.2022.
//

import UIKit

final class SearchBuilder {
    static func make() -> UINavigationController{
        let vc = SearchViewController()
        
        let viewModel = SearchViewModel(newsService: appContainer.newsService)
        viewModel.delegate = vc
        vc.viewModel = viewModel
        
        return UINavigationController(rootViewController: vc)
    }
}
