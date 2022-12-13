//
//  NewsEndpoint.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation

enum NewsEndpoint: HTTPEndpoint {
    //https://newsdata.io/api/1/news?apikey=pub_12891bbaa86f6767ce902a41954a6cdbd598d

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
