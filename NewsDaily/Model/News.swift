//
//  News.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation

struct News: Decodable {
    let status: String
    let totalResults: Int
    let nextPage: String?
    let results: [Article]
}

// MARK: - Article
struct Article: Decodable, Equatable {
    let title: String
    let link: String
    let description: String?
    let image_url: String?
    let source_id: String
}

