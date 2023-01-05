//
//  DetailViewModel.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 6.12.2022.
//

import Foundation

final class DetailViewModel: DetailViewModelProtocol {
    weak var delegate: DetailViewDelagate?

    //MARK: - Injections
    private var article: Article
    private var coreDataManager: CoreDataManagerProtocol
    
    init(article: Article, coreDataManager: CoreDataManagerProtocol) {
        self.article = article
        self.coreDataManager = coreDataManager
    }
    
    //MARK: - Main Functions
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
    
    //MARK: - Helper Functions
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
