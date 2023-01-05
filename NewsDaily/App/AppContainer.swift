//
//  AppContainer.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation

struct AppContainer {
    static let service = Service()
    static let coreDataManager = CoreDataManager()
}

struct ServiceContainer {
    static let newsService = NewsService(service: AppContainer.service)
}


