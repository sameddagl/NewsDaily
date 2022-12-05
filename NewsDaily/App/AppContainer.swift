//
//  AppContainer.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation

let appContainer = AppContainer()

final class AppContainer {
    let service = Service()
    let newsService = NewsService(service: Service())
    let topHeadlinesService = TopHeadlinesService(service: Service())
}
