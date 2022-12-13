//
//  DetailViewModel.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 6.12.2022.
//

import Foundation

final class DetailViewModel: DetailViewModelProtocol {
    weak var delegate: DetailViewDelagate?

    private var article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    func load() {
        let detailPresentation = ArticlePresentation(article: article)
        notify(.load(detailPresentation))
    }
    
    func requestWebPage() {
        notify(.showWebPage(url: article.link))
    }
    
    private func notify(_ output: DetaiViewModellOutput) {
        delegate?.handleOutput(output)
    }
}
