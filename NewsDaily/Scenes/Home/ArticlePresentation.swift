//
//  HomePresentation.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation

struct ArticlePresentation: Hashable {
    let title: String
    let articleDescription: String?
    let urlToImage: String?
    let publishDate: Date
    let sourceName: String
    
    init(article: Article) {
        self.title = article.title
        self.articleDescription = article.articleDescription
        self.urlToImage = article.urlToImage
        self.publishDate = article.publishedAt
        self.sourceName = article.source.name
    }
}
