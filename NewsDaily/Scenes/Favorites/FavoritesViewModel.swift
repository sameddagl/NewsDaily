//
//  FavoritesViewModel.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 4.01.2023.
//

import Foundation

final class FavoritesViewModel: FavoritesViewModelProtocol {
    var delegate: FavoritesViewModelDelegate?
    
    private let coreDataManager: CoreDataManagerProtocol
    private let coordinator: FavoritesCoordinator
    
    init(coreDataManager: CoreDataManagerProtocol, coordinator: FavoritesCoordinator) {
        self.coreDataManager = coreDataManager
        self.coordinator = coordinator
    }
    
    private var savedArticles = [NewsModel]()
    
    func load() {
        savedArticles = coreDataManager.fetchSavedNews()
        if savedArticles.isEmpty {
            notify(.emptyState(message: "no_saved_article".localized()))
            notify(.didUploadWithNews(news: []))
            return
        }
        
        notify(.didUploadWithNews(news: savedArticles.map { ArticlePresentation(article: $0) }))
        notify(.removeEmptyState)
    }
    
    func selectItem(at index: Int) {
        let selectedArticle = savedArticles[index]
        
        coordinator.goToDetail(article: Article(title: selectedArticle.title!,
                                                link: selectedArticle.link!,
                                                description: selectedArticle.descript,
                                                image_url: selectedArticle.imageURL,
                                                source_id: selectedArticle.source_id!))
    }
    
    private func notify(_ output: FavoritesOutput) {
        delegate?.handleOutput(output)
    }
}
