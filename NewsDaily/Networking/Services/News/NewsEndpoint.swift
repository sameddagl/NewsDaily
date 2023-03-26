//
//  NewsEndpoint.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation

enum NewsEndpoint: HTTPEndpoint {
    case fetchNews(category: NewsCategories, page: String?)
    case searchFor(q: String, page: String?)
    
    var path: String {
        return Paths.latest
    }
    
    var params: [URLQueryItem] {
        switch self {
        case .fetchNews(let category, let page):
            return [
                URLQueryItem(name: "apiKey", value: NetworkHelper.apiKey),
                URLQueryItem(name: "language", value: Locale.current.languageCode),
                URLQueryItem(name: "category", value: category.rawValue),
                URLQueryItem(name: "page", value: page),
            ]
        case .searchFor(let q, let page):
            return [
                URLQueryItem(name: "apiKey", value: NetworkHelper.apiKey),
                URLQueryItem(name: "language", value: Locale.current.languageCode),
                URLQueryItem(name: "page", value: page),
                URLQueryItem(name: "q", value: q)
            ]
        }
    }
}
