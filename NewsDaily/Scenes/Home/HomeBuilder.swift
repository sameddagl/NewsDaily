//
//  HomeBuilder.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import UIKit

final class HomeBuilder {
    static func make() -> UINavigationController {
        let viewModel = HomeViewModel(newsService: appContainer.newsService)

        let vc = HomeViewController(viewModel: viewModel)

        let nav = UINavigationController(rootViewController: vc)
        
        return nav
    }
}
