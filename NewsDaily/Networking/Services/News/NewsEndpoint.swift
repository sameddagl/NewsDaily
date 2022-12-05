//
//  NewsEndpoint.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation

enum NewsEndpoint: HTTPEndpoint {
    //https://newsapi.org/v2/everything?q=bitcoin&apiKey=5505a723f936442a899ba1791dbd6794&language=tr&page=1&sortBy=popularity&searchIn=content
    
    case fetchNews(category: NewsCategories, page: Int)
    var path: String {
        return Paths.everyThing
    }
    
    var params: [URLQueryItem] {
        switch self {
        case .fetchNews(let category, let page):
            return [
                URLQueryItem(name: "apiKey", value: NetworkHelper.apiKey),
                URLQueryItem(name: "language", value: Locale.current.languageCode),
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "sortBy", value: "popularity"),
                URLQueryItem(name: "searchIn", value: "content"),
                URLQueryItem(name: "q", value: category.rawValue)
            ]
        }
    }
    
    
}
