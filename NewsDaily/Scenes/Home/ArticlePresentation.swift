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
    let publishDate: String
    let sourceName: String
    let content: String?
    
    init(article: Article) {
        self.title = article.title
        self.articleDescription = article.description
        self.urlToImage = article.image_url
        self.publishDate = article.pubDate
        self.sourceName = article.source_id
        self.content = ""
    }
}
