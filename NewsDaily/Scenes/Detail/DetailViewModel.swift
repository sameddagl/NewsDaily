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
    private var coreDataManager: CoreDataManagerProtocol
    
    init(article: Article, coreDataManager: CoreDataManagerProtocol) {
        self.article = article
        self.coreDataManager = coreDataManager
    }
    
    func load() {
        let detailPresentation = ArticlePresentation(article: article)
        notify(.load(detailPresentation))
        
        notify(.isSaved(checkIfSaved()))
    }
    
    func saveTapped(isSelected: Bool) {
        if isSelected {
            print("delete")
            coreDataManager.delete(article: article)
        }
        else {
            print("save")
            coreDataManager.save(article: article)
        }
    }
    
    func requestWebPage() {
        notify(.showSafariView(url: article.link))
    }
    
    private func checkIfSaved() -> Bool {
        let savedArticles = coreDataManager.fetchSavedNews()
        
        for savedArticle in savedArticles {
            if savedArticle.title == article.title {
                return true
            }
        }
        
        return false
    }
    
    private func notify(_ output: DetaiViewModelOutput) {
        delegate?.handleOutput(output)
    }
}
