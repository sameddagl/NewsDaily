//
//  TopHeadlinesEndpoint.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation
//GET https://newsapi.org/v2/top-headlines?country=us&apiKey=5505a723f936442a899ba1791dbd6794

enum TopHeadlinesEndpoint: HTTPEndpoint {
    case fetchNews(page: Int)

    var path: String {
        return Paths.topHeadlines
    }
    
    var params: [URLQueryItem] {
        switch self {
        case .fetchNews(let page):
            return [
                URLQueryItem(name: "apiKey", value: NetworkHelper.apiKey),
                URLQueryItem(name: "country", value: "us"),
                URLQueryItem(name: "category", value: "business"),
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "pageSize", value: String(20))
            ]
        }
    }
}
