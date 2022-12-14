//
//  NewsEndpoint.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation

enum NewsEndpoint: HTTPEndpoint {
    case fetchNews(category: NewsCategories, page: Int)
    case searchFor(q: String, page: Int)
    
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
                URLQueryItem(name: "page", value: String(page)),
            ]
        case .searchFor(let q, let page):
            return [
                URLQueryItem(name: "apiKey", value: NetworkHelper.apiKey),
                URLQueryItem(name: "language", value: Locale.current.languageCode),
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "q", value: q)
            ]
        }
    }
}
